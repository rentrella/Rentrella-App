/// 서버 연동 설정 — `--dart-define`으로 주입한다.
///
/// ```
/// flutter run --dart-define=API_BASE_URL=http://192.168.0.10:8888
/// flutter run --dart-define=USE_MOCK=true
/// ```
abstract final class ApiConfig {
  /// 기본값은 안드로이드 에뮬레이터에서 호스트 PC의 localhost
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8888',
  );

  /// true면 서버 대신 Mock 리포지토리를 사용한다.
  static const useMock = bool.fromEnvironment('USE_MOCK');

  static const timeout = Duration(seconds: 10);
}
