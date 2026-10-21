part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// 화면 진입 시 날씨·우산 목록 조회
final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

final class HomeUmbrellaBorrowed extends HomeEvent {
  const HomeUmbrellaBorrowed(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}

final class HomeUmbrellaReturned extends HomeEvent {
  const HomeUmbrellaReturned(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
