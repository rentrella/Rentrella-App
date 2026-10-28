part of 'home_bloc.dart';

final class HomeState extends Equatable {
  const HomeState({
    this.status = LoadStatus.initial,
    this.weather,
    this.umbrellas = const [],
    this.availableCount = 0,
    this.myRental = MyRentalModel.none,
    this.errorMessage,
  });

  final LoadStatus status;
  final WeatherModel? weather;
  final List<UmbrellaModel> umbrellas;

  /// 대여 가능한 우산 수 (서버 `GET /umbrella`)
  final int availableCount;
  final MyRentalModel myRental;

  /// 조회·대여·반납 실패 메시지 (스낵바로 표시)
  final String? errorMessage;

  int get total => umbrellas.length;

  HomeState copyWith({
    LoadStatus? status,
    WeatherModel? weather,
    List<UmbrellaModel>? umbrellas,
    int? availableCount,
    MyRentalModel? myRental,
    ValueGetter<String?>? errorMessage,
  }) => HomeState(
    status: status ?? this.status,
    weather: weather ?? this.weather,
    umbrellas: umbrellas ?? this.umbrellas,
    availableCount: availableCount ?? this.availableCount,
    myRental: myRental ?? this.myRental,
    errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
  );

  @override
  List<Object?> get props => [
    status,
    weather,
    umbrellas,
    availableCount,
    myRental,
    errorMessage,
  ];
}
