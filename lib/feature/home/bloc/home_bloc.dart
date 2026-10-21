import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/core/enum/load_status.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
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
      (e, emit) => _replace(emit, _umbrellaRepository.borrow(e.id)),
    );
    on<HomeUmbrellaReturned>(
      (e, emit) => _replace(emit, _umbrellaRepository.returnUmbrella(e.id)),
    );
  }

  final UmbrellaRepository _umbrellaRepository;
  final WeatherRepository _weatherRepository;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final (weather, umbrellas) = await (
        _weatherRepository.fetchWeather(),
        _umbrellaRepository.fetchUmbrellas(),
      ).wait;
      emit(
        state.copyWith(
          status: LoadStatus.success,
          weather: weather,
          umbrellas: umbrellas,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  /// 대여/반납 결과로 받은 우산을 목록에서 교체
  Future<void> _replace(
    Emitter<HomeState> emit,
    Future<UmbrellaModel> request,
  ) async {
    final updated = await request;
    emit(
      state.copyWith(
        umbrellas: [
          for (final e in state.umbrellas) e.id == updated.id ? updated : e,
        ],
      ),
    );
  }
}
