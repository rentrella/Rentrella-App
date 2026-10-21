import 'package:equatable/equatable.dart';
import 'package:rentrella/core/enum/weather_status.dart';

class WeatherModel extends Equatable {
  const WeatherModel({required this.status, required this.temperature});

  final WeatherStatus status;

  /// 섭씨 온도
  final double temperature;

  @override
  List<Object?> get props => [status, temperature];
}
