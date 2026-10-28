import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/feature/home/data/models/my_rental_model.dart';
import 'package:rentrella/feature/home/data/models/umbrella_model.dart';
import 'package:rentrella/feature/home/data/repositories/umbrella_repository.dart';

/// 서버 없이 사용하는 목 구현체 — 상태별 우산 1개씩, 메모리에서만 변경된다.
class MockUmbrellaRepository implements UmbrellaRepository {
  final Map<int, UmbrellaModel> _items = {
    for (final (i, status) in UmbrellaStatus.values.indexed)
      i + 1: UmbrellaModel(id: i + 1, status: status, user: '{{user}}'),
  };

  @override
  Future<List<UmbrellaModel>> fetchUmbrellas() async => _items.values.toList();

  @override
  Future<int> fetchAvailableCount() async =>
      _items.values.where((e) => e.status == UmbrellaStatus.ready).length;

  @override
  Future<MyRentalModel> fetchMyRental() async {
    final mine = _items.values.where(
      (e) =>
          e.status == UmbrellaStatus.rentingByMe ||
          e.status == UmbrellaStatus.overdueByMe,
    );
    return mine.isEmpty
        ? MyRentalModel.none
        : MyRentalModel(hasRental: true, deviceId: mine.first.id);
  }

  @override
  Future<UmbrellaModel> borrow(int id) async =>
      _items[id] = _items[id]!.copyWith(status: UmbrellaStatus.rentingByMe);

  @override
  Future<UmbrellaModel> returnUmbrella(int id) async =>
      _items[id] = _items[id]!.copyWith(status: UmbrellaStatus.ready);
}
