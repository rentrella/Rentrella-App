import 'package:rentrella/core/enum/weather_status.dart';
import 'package:rentrella/feature/home/data/models/weather_model.dart';
import 'package:rentrella/feature/home/data/repositories/weather_repository.dart';

/// 서버 연동 전 사용하는 목 구현체
class MockWeatherRepository implements WeatherRepository {
  @override
  Future<WeatherModel> fetchWeather() async =>
      const WeatherModel(status: WeatherStatus.snowy, temperature: 25);
}
