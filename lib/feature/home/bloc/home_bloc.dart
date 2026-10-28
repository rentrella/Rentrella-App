import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/core/enum/load_status.dart';
import 'package:rentrella/core/network/api_exception.dart';
import 'package:rentrella/feature/home/data/models/my_rental_model.dart';
import 'package:rentrella/feature/home/data/models/umbrella_model.dart';
import 'package:rentrella/feature/home/data/models/weather_model.dart';
import 'package:rentrella/feature/home/data/repositories/umbrella_repository.dart';
import 'package:rentrella/feature/home/data/repositories/weather_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this._umbrellaRepository,
    required this._weatherRepository,
  }) : super(const HomeState()) {
    on<HomeStarted>(_onStarted);
    on<HomeUmbrellaBorrowed>(
      (e, emit) => _replace(emit, () => _umbrellaRepository.borrow(e.id)),
    );
    on<HomeUmbrellaReturned>(
      (e, emit) =>
          _replace(emit, () => _umbrellaRepository.returnUmbrella(e.id)),
    );
  }

  final UmbrellaRepository _umbrellaRepository;
  final WeatherRepository _weatherRepository;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading, errorMessage: () => null));
    try {
      final weather = await _weatherRepository.fetchWeather();
      final umbrellas = await _umbrellaRepository.fetchUmbrellas();
      final availableCount = await _umbrellaRepository.fetchAvailableCount();
      final myRental = await _umbrellaRepository.fetchMyRental();
      emit(
        state.copyWith(
          status: LoadStatus.success,
          weather: weather,
          umbrellas: umbrellas,
          availableCount: availableCount,
          myRental: myRental,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: LoadStatus.failure,
          errorMessage: () => e.message,
        ),
      );
    }
  }

  /// 대여/반납 결과로 받은 우산을 목록에서 교체하고 개수·내 대여를 다시 조회
  Future<void> _replace(
    Emitter<HomeState> emit,
    Future<UmbrellaModel> Function() request,
  ) async {
    emit(state.copyWith(errorMessage: () => null));
    try {
      final updated = await request();
      final availableCount = await _umbrellaRepository.fetchAvailableCount();
      final myRental = await _umbrellaRepository.fetchMyRental();
      emit(
        state.copyWith(
          umbrellas: [
            for (final e in state.umbrellas) e.id == updated.id ? updated : e,
          ],
          availableCount: availableCount,
          myRental: myRental,
        ),
      );
    } on ApiException catch (e) {
      emit(state.copyWith(errorMessage: () => e.message));
    }
  }
}
