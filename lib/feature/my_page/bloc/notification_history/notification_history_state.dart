part of 'notification_history_bloc.dart';

final class NotificationHistoryState extends Equatable {
  const NotificationHistoryState({
    this.status = LoadStatus.initial,
    this.items = const [],
    this.page = 1,
    this.lastPage = 1,
    this.total = 0,
    this.unread = 0,
  });

  final LoadStatus status;
  final List<NotificationModel> items;
  final int page;
  final int lastPage;
  final int total;
  final int unread;

  bool get hasPrev => page > 1;
  bool get hasNext => page < lastPage;

  NotificationHistoryState copyWith({LoadStatus? status}) =>
      NotificationHistoryState(
        status: status ?? this.status,
        items: items,
        page: page,
        lastPage: lastPage,
        total: total,
        unread: unread,
      );

  NotificationHistoryState withPage(NotificationPage p) =>
      NotificationHistoryState(
        status: LoadStatus.success,
        items: p.items,
        page: p.page,
        lastPage: p.lastPage,
        total: p.total,
        unread: p.unread,
      );

  @override
  List<Object?> get props => [status, items, page, lastPage, total, unread];
}
