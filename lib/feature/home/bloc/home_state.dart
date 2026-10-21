part of 'home_bloc.dart';

final class HomeState extends Equatable {
  const HomeState({
    this.status = LoadStatus.initial,
    this.weather,
    this.umbrellas = const [],
  });

  final LoadStatus status;
  final WeatherModel? weather;
  final List<UmbrellaModel> umbrellas;

  int get total => umbrellas.length;

  /// 대여 가능한 우산 수
  int get availableCount =>
      umbrellas.where((e) => e.status == UmbrellaStatus.ready).length;

  HomeState copyWith({
    LoadStatus? status,
    WeatherModel? weather,
    List<UmbrellaModel>? umbrellas,
  }) => HomeState(
    status: status ?? this.status,
    weather: weather ?? this.weather,
    umbrellas: umbrellas ?? this.umbrellas,
  );

  @override
  List<Object?> get props => [status, weather, umbrellas];
}
