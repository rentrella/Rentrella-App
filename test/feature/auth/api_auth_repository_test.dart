import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/core/network/api_client.dart';
import 'package:rentrella/core/network/api_exception.dart';
import 'package:rentrella/core/network/token_storage.dart';
import 'package:rentrella/feature/auth/core/data/repositories/api_auth_repository.dart';

import '../../helpers/fake_http_adapter.dart';

void main() {
  const email = 's12345@gsm.hs.kr';

  late FakeHttpAdapter adapter;
  late MemoryTokenStorage storage;
  late ApiAuthRepository repository;

  setUp(() {
    adapter = FakeHttpAdapter();
    storage = MemoryTokenStorage();
    repository = ApiAuthRepository(
      dio: createApiClient(
        tokenStorage: storage,
        baseUrl: 'http://test',
        adapter: adapter,
      ),
      tokenStorage: storage,
    );
  });

  test('login: 토큰 응답을 저장하고 Authorization 없이 요청한다', () async {
    adapter.on('POST /auth/login', 200, {
      'tokenType': 'Bearer',
      'accessToken': 'access',
      'refreshToken': 'refresh',
      'expiresIn': 3600,
    });

    await repository.login(
      email: email,
      password: 'abc12345',
      keepLoggedIn: true,
    );

    final req = adapter.requests.single;
    expect(adapter.bodyOf(req), {'email': email, 'password': 'abc12345'});
    expect(req.headers['Authorization'], isNull);
    expect(
      await storage.read(),
      const AuthTokens(accessToken: 'access', refreshToken: 'refresh'),
    );
    expect(await repository.hasSession(), isTrue);
  });

  test('login 실패: 서버 에러 바디의 message를 ApiException으로 전달한다', () async {
    adapter.on('POST /auth/login', 401, errorBody(401, '비밀번호가 올바르지 않습니다.'));

    await expectLater(
      repository.login(email: email, password: 'wrong', keepLoggedIn: false),
      throwsA(
        isA<ApiException>()
            .having((e) => e.message, 'message', '비밀번호가 올바르지 않습니다.')
            .having((e) => e.statusCode, 'statusCode', 401),
      ),
    );
    expect(await storage.read(), isNull);
  });

  test('signup: 인증코드 발송 후 이름·인증코드를 포함해 가입한다', () async {
    adapter
      ..on('POST /auth/email/signup-code', 202)
      ..on('POST /auth/signup', 200, {
        'userId': 1,
        'email': email,
        'name': '홍길동',
      });

    await repository.sendSignupCode(email: email);
    await repository.signup(
      email: email,
      password: 'abc12345',
      name: '홍길동',
      verificationCode: '123456',
    );

    expect(adapter.bodyOf(adapter.requests[0]), {'email': email});
    expect(adapter.bodyOf(adapter.requests[1]), {
      'email': email,
      'password': 'abc12345',
      'name': '홍길동',
      'verificationCode': '123456',
    });
  });

  test('비밀번호 재설정: 코드 발송 후 /auth/password/reset', () async {
    adapter
      ..on('POST /auth/email/password-reset-code', 202)
      ..on('POST /auth/password/reset', 204);

    await repository.sendVerificationCode(email: email);
    await repository.changePassword(
      email: email,
      code: '123456',
      password: 'newpass123',
    );

    expect(adapter.requests.map((e) => e.path), [
      '/auth/email/password-reset-code',
      '/auth/password/reset',
    ]);
    expect(adapter.bodyOf(adapter.requests[1]), {
      'email': email,
      'verificationCode': '123456',
      'newPassword': 'newpass123',
    });
  });

  test('logout: refresh token을 보내고, 서버가 실패해도 토큰을 지운다', () async {
    await storage.save(
      const AuthTokens(accessToken: 'access', refreshToken: 'refresh'),
    );
    adapter.on('POST /auth/logout', 500, errorBody(500, 'error'));

    await repository.logout();

    expect(adapter.bodyOf(adapter.requests.single), {
      'refreshToken': 'refresh',
    });
    expect(await storage.read(), isNull);
  });
}
