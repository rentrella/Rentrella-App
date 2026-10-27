import 'package:rentrella/feature/my_page/data/models/notification_model.dart';

/// 알림 내역 및 알림 수신 설정 인터페이스
///
/// 현재는 [MockNotificationRepository]를 사용하며, 서버 연동 시 구현체만 교체한다.
abstract interface class NotificationRepository {
  /// [page]는 1부터 시작한다.
  Future<NotificationPage> fetchNotifications({required int page});

  Future<void> readAll();

  /// 읽은 알림 전체 삭제
  Future<void> deleteRead();

  /// 알림 수신 허용 여부
  Future<bool> fetchAllowed();

  Future<void> updateAllowed(bool allowed);
}
