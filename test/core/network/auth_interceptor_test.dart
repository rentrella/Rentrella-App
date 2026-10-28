import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/core/network/api_client.dart';
import 'package:rentrella/core/network/api_exception.dart';
import 'package:rentrella/core/network/token_storage.dart';
import 'package:rentrella/feature/home/data/repositories/api_umbrella_repository.dart';

import '../../helpers/fake_http_adapter.dart';

void main() {
  const oldTokens = AuthTokens(accessToken: 'old', refreshToken: 'refresh');
  const reissued = {
    'tokenType': 'Bearer',
    'accessToken': 'new',
    'refreshToken': 'refresh2',
    'expiresIn': 3600,
  };

  late FakeHttpAdapter adapter;
  late MemoryTokenStorage storage;
  late int expiredCount;
  late ApiUmbrellaRepository repository;

  setUp(() {
    adapter = FakeHttpAdapter();
    storage = MemoryTokenStorage(oldTokens);
    expiredCount = 0;
    repository = ApiUmbrellaRepository(
      dio: createApiClient(
        tokenStorage: storage,
        baseUrl: 'http://test',
        adapter: adapter,
        onSessionExpired: () => expiredCount++,
      ),
    );
  });

  test('저장된 access token을 Authorization 헤더로 보낸다', () async {
    adapter.on('GET /umbrella', 200, {'count': 1});

    await repository.fetchAvailableCount();

    expect(adapter.requests.single.headers['Authorization'], 'Bearer old');
  });

  test('401이면 /auth/reissue로 재발급 후 새 토큰으로 재시도한다', () async {
    adapter
      ..on('GET /umbrella', 401, errorBody(401, 'Authentication is required.'))
      ..on('GET /umbrella', 200, {'count': 3})
      ..on('POST /auth/reissue', 200, reissued);

    expect(await repository.fetchAvailableCount(), 3);

    final reissue = adapter.requests[1];
    expect(reissue.path, '/auth/reissue');
    expect(adapter.bodyOf(reissue), {'refreshToken': 'refresh'});
    expect(adapter.requests[2].headers['Authorization'], 'Bearer new');
    expect(
      await storage.read(),
      const AuthTokens(accessToken: 'new', refreshToken: 'refresh2'),
    );
    expect(expiredCount, 0);
  });

  test('재발급도 실패하면 토큰을 지우고 세션 만료를 알린다', () async {
    adapter
      ..on('GET /umbrella', 401, errorBody(401, 'Authentication is required.'))
      ..on('POST /auth/reissue', 401, errorBody(401, 'Invalid refresh token.'));

    await expectLater(
      repository.fetchAvailableCount(),
      throwsA(
        isA<ApiException>()
            .having((e) => e.statusCode, 'statusCode', 401)
            .having((e) => e.message, 'message', 'Authentication is required.'),
      ),
    );
    expect(await storage.read(), isNull);
    expect(expiredCount, 1);
  });
}
