import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/core/enum/load_status.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/feature/home/bloc/home_bloc.dart';
import 'package:rentrella/feature/home/data/repositories/mock_umbrella_repository.dart';
import 'package:rentrella/feature/home/data/repositories/mock_weather_repository.dart';

void main() {
  HomeBloc build() => HomeBloc(
    umbrellaRepository: MockUmbrellaRepository(),
    weatherRepository: MockWeatherRepository(),
  );

  blocTest<HomeBloc, HomeState>(
    '진입 시 날씨와 우산 목록을 불러온다',
    build: build,
    act: (bloc) => bloc.add(const HomeStarted()),
    verify: (bloc) {
      expect(bloc.state.status, LoadStatus.success);
      expect(bloc.state.weather, isNotNull);
      expect(bloc.state.total, UmbrellaStatus.values.length);
      expect(bloc.state.availableCount, 1);
    },
  );

  blocTest<HomeBloc, HomeState>(
    '대여하면 나의 대여로, 반납하면 대여 가능으로 바뀐다',
    build: build,
    act: (bloc) async {
      bloc.add(const HomeStarted());
      await Future<void>.delayed(Duration.zero);
      final id = bloc.state.umbrellas
          .firstWhere((e) => e.status == UmbrellaStatus.ready)
          .id;

      bloc.add(HomeUmbrellaBorrowed(id));
      await Future<void>.delayed(Duration.zero);
      expect(
        bloc.state.umbrellas.firstWhere((e) => e.id == id).status,
        UmbrellaStatus.rentingByMe,
      );

      bloc.add(HomeUmbrellaReturned(id));
    },
    verify: (bloc) => expect(bloc.state.availableCount, 1),
  );
}
