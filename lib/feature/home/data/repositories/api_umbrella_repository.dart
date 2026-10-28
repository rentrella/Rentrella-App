import 'package:dio/dio.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/core/network/api_exception.dart';
import 'package:rentrella/feature/home/data/models/my_rental_model.dart';
import 'package:rentrella/feature/home/data/models/umbrella_model.dart';
import 'package:rentrella/feature/home/data/repositories/mock_umbrella_repository.dart';
import 'package:rentrella/feature/home/data/repositories/umbrella_repository.dart';

/// rentrella/backend `/umbrella/*` 연동 구현체
///
/// 서버는 대여 가능 개수와 내 대여 칸(deviceId)만 제공한다.
class ApiUmbrellaRepository implements UmbrellaRepository {
  ApiUmbrellaRepository({required this._dio, UmbrellaRepository? slots})
    : _slots = slots ?? MockUmbrellaRepository();

  final Dio _dio;

  // TODO 서버에 칸(device) 목록 API가 생기면 교체. 지금은 목 칸 목록에 내 대여만 반영한다.
  final UmbrellaRepository _slots;

  @override
  Future<List<UmbrellaModel>> fetchUmbrellas() async {
    final slots = await _slots.fetchUmbrellas();
    final myDeviceId = (await fetchMyRental()).deviceId;

    return [
      for (final e in slots)
        if (e.id == myDeviceId)
          e.copyWith(status: UmbrellaStatus.rentingByMe, user: e.user)
        else
          // 목 데이터의 "나의" 상태는 서버 기준이 아니므로 다른 유저 상태로 바꾼다.
          switch (e.status) {
            UmbrellaStatus.rentingByMe => e.copyWith(
              status: UmbrellaStatus.rented,
              user: e.user,
            ),
            UmbrellaStatus.overdueByMe => e.copyWith(
              status: UmbrellaStatus.overdue,
              user: e.user,
            ),
            _ => e,
          },
    ];
  }

  @override
  Future<int> fetchAvailableCount() => guardApi(() async {
    final res = await _dio.get<Map<String, dynamic>>('/umbrella');
    return (res.data!['count'] as num).toInt();
  });

  @override
  Future<MyRentalModel> fetchMyRental() => guardApi(() async {
    final res = await _dio.get<Map<String, dynamic>>('/umbrella/me');
    return MyRentalModel.fromJson(res.data!);
  });

  @override
  Future<UmbrellaModel> borrow(int id) async {
    await _command('/umbrella/Rental', id);
    return UmbrellaModel(id: id, status: UmbrellaStatus.rentingByMe);
  }

  @override
  Future<UmbrellaModel> returnUmbrella(int id) async {
    await _command('/umbrella/return', id);
    return UmbrellaModel(id: id, status: UmbrellaStatus.ready);
  }

  /// 대여·반납 명령 — 응답 `{status, msg}`의 status가 success가 아니면 실패
  Future<void> _command(String path, int deviceId) => guardApi(() async {
    final res = await _dio.post<Map<String, dynamic>>(
      path,
      data: {'deviceId': deviceId},
    );
    final body = res.data ?? const {};
    if (body['status'] != 'success') {
      throw ApiException(
        body['msg'] as String? ?? '요청을 처리하지 못했어요.',
        statusCode: res.statusCode,
      );
    }
  });
}
