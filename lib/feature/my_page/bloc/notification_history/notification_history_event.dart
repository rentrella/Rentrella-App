part of 'notification_history_bloc.dart';

sealed class NotificationHistoryEvent extends Equatable {
  const NotificationHistoryEvent();

  @override
  List<Object?> get props => [];
}

final class NotificationHistoryStarted extends NotificationHistoryEvent {
  const NotificationHistoryStarted();
}

final class NotificationHistoryPageChanged extends NotificationHistoryEvent {
  const NotificationHistoryPageChanged(this.page);

  final int page;

  @override
  List<Object?> get props => [page];
}

final class NotificationHistoryReadAllRequested
    extends NotificationHistoryEvent {
  const NotificationHistoryReadAllRequested();
}

final class NotificationHistoryDeleteReadRequested
    extends NotificationHistoryEvent {
  const NotificationHistoryDeleteReadRequested();
}
