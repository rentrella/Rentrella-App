import 'package:rentrella/feature/home/data/models/weather_model.dart';

/// 현재 날씨 조회 인터페이스
abstract interface class WeatherRepository {
  Future<WeatherModel> fetchWeather();
}
