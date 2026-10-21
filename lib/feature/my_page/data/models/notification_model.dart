import 'package:equatable/equatable.dart';
import 'package:rentrella/core/enum/notification_status.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.id,
    required this.status,
    required this.title,
    required this.message,
    required this.date,
    this.endDate,
    this.overdue,
    this.read = false,
  });

  final int id;
  final NotificationStatus status;
  final String title;
  final String message;

  /// 알림 일자 (대여 알림의 경우 대여 시작 일자)
  final DateTime date;

  /// 반납(예정) 일자 — 대여 관련 알림에서만 사용
  final DateTime? endDate;
  final Duration? overdue;

  final bool read;

  NotificationModel copyWith({int? id, bool? read}) => NotificationModel(
    id: id ?? this.id,
    status: status,
    title: title,
    message: message,
    date: date,
    endDate: endDate,
    overdue: overdue,
    read: read ?? this.read,
  );

  @override
  List<Object?> get props => [
    id,
    status,
    title,
    message,
    date,
    endDate,
    overdue,
    read,
  ];
}

/// 알림 목록 한 페이지와 집계 정보
class NotificationPage extends Equatable {
  const NotificationPage({
    required this.items,
    required this.page,
    required this.lastPage,
    required this.total,
    required this.unread,
  });

  final List<NotificationModel> items;
  final int page;
  final int lastPage;

  /// 전체 알림 수
  final int total;

  /// 미확인 알림 수
  final int unread;

  @override
  List<Object?> get props => [items, page, lastPage, total, unread];
}
