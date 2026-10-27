import 'package:rentrella/feature/home/data/models/umbrella_model.dart';

/// 우산 목록 조회 및 대여/반납 인터페이스
///
/// 현재는 [MockUmbrellaRepository]를 사용하며, 서버 연동 시 구현체만 교체한다.
abstract interface class UmbrellaRepository {
  Future<List<UmbrellaModel>> fetchUmbrellas();

  /// 대여 후 변경된 우산을 반환한다.
  Future<UmbrellaModel> borrow(int id);

  /// 반납 후 변경된 우산을 반환한다.
  Future<UmbrellaModel> returnUmbrella(int id);
}
