part of 'notification_setting_bloc.dart';

sealed class NotificationSettingEvent extends Equatable {
  const NotificationSettingEvent();

  @override
  List<Object?> get props => [];
}

final class NotificationSettingStarted extends NotificationSettingEvent {
  const NotificationSettingStarted();
}

final class NotificationSettingChanged extends NotificationSettingEvent {
  const NotificationSettingChanged(this.allowed);

  final bool allowed;

  @override
  List<Object?> get props => [allowed];
}
