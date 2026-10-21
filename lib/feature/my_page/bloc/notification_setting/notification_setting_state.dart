part of 'notification_setting_bloc.dart';

final class NotificationSettingState extends Equatable {
  const NotificationSettingState({this.allowed = true});

  /// 알림 수신 허용 여부
  final bool allowed;

  @override
  List<Object?> get props => [allowed];
}
