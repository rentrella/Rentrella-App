import 'package:rentrella/feature/home/data/models/my_rental_model.dart';
import 'package:rentrella/feature/home/data/models/umbrella_model.dart';

/// 우산 목록 조회 및 대여/반납 인터페이스
///
/// 실패 시 [ApiException]을 던진다. 구현체: [ApiUmbrellaRepository], [MockUmbrellaRepository]
abstract interface class UmbrellaRepository {
  Future<List<UmbrellaModel>> fetchUmbrellas();

  /// 대여 가능한 우산 수
  Future<int> fetchAvailableCount();

  /// 내가 대여 중인 우산
  Future<MyRentalModel> fetchMyRental();

  /// 대여 후 변경된 우산을 반환한다.
  Future<UmbrellaModel> borrow(int id);

  /// 반납 후 변경된 우산을 반환한다.
  Future<UmbrellaModel> returnUmbrella(int id);
}
