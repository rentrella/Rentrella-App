import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/core/network/api_client.dart';
import 'package:rentrella/core/network/api_exception.dart';
import 'package:rentrella/core/network/token_storage.dart';
import 'package:rentrella/feature/home/data/models/my_rental_model.dart';
import 'package:rentrella/feature/home/data/repositories/api_umbrella_repository.dart';

import '../../helpers/fake_http_adapter.dart';

void main() {
  const accepted = {'status': 'success', 'msg': '명령 접수됨'};

  late FakeHttpAdapter adapter;
  late ApiUmbrellaRepository repository;

  setUp(() {
    adapter = FakeHttpAdapter();
    repository = ApiUmbrellaRepository(
      dio: createApiClient(
        tokenStorage: MemoryTokenStorage(
          const AuthTokens(accessToken: 'access', refreshToken: 'refresh'),
        ),
        baseUrl: 'http://test',
        adapter: adapter,
      ),
    );
  });

  test('GET /umbrella → 대여 가능 개수', () async {
    adapter.on('GET /umbrella', 200, {'count': 4});

    expect(await repository.fetchAvailableCount(), 4);
  });

  test('GET /umbrella/me → 내 대여', () async {
    adapter.on('GET /umbrella/me', 200, {'hasRental': true, 'deviceId': 3});

    expect(
      await repository.fetchMyRental(),
      const MyRentalModel(hasRental: true, deviceId: 3),
    );
  });

  test('GET /umbrella/me → 대여 없음', () async {
    adapter.on('GET /umbrella/me', 200, {'hasRental': false, 'deviceId': null});

    expect(await repository.fetchMyRental(), MyRentalModel.none);
  });

  test('우산 목록: 내 대여 칸만 나의 대여로 표시한다', () async {
    adapter.on('GET /umbrella/me', 200, {'hasRental': true, 'deviceId': 1});

    final list = await repository.fetchUmbrellas();

    expect(list.first.status, UmbrellaStatus.rentingByMe);
    expect(
      list
          .skip(1)
          .where(
            (e) =>
                e.status == UmbrellaStatus.rentingByMe ||
                e.status == UmbrellaStatus.overdueByMe,
          ),
      isEmpty,
    );
  });

  test('대여: POST /umbrella/Rental {deviceId}', () async {
    adapter.on('POST /umbrella/Rental', 200, accepted);

    final result = await repository.borrow(2);

    final req = adapter.requests.single;
    expect(adapter.bodyOf(req), {'deviceId': 2});
    expect(req.headers['Authorization'], 'Bearer access');
    expect(result.status, UmbrellaStatus.rentingByMe);
  });

  test('반납: POST /umbrella/return {deviceId}', () async {
    adapter.on('POST /umbrella/return', 200, accepted);

    final result = await repository.returnUmbrella(2);

    expect(adapter.bodyOf(adapter.requests.single), {'deviceId': 2});
    expect(result.status, UmbrellaStatus.ready);
  });

  test('status가 success가 아니면 msg로 실패한다', () async {
    adapter.on('POST /umbrella/Rental', 200, {
      'status': 'fail',
      'msg': '대여할 수 없는 상태입니다.',
    });

    await expectLater(
      repository.borrow(2),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          '대여할 수 없는 상태입니다.',
        ),
      ),
    );
  });
}
