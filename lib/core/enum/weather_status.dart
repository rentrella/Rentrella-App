enum WeatherStatus {
  rainy(value: 'RAINY', label: '비'),
  cloudy(value: 'CLOUDY', label: '흐림'),
  sunny(value: 'SUNNY', label: '맑음'),
  snowy(value: 'SNOWY', label: '눈');

  final String value;
  final String label;

  const WeatherStatus({required this.value, required this.label});
}
