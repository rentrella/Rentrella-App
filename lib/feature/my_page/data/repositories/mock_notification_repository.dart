import 'dart:math';

import 'package:rentrella/core/enum/notification_status.dart';
import 'package:rentrella/feature/my_page/data/models/notification_model.dart';
import 'package:rentrella/feature/my_page/data/repositories/notification_repository.dart';

/// 서버 연동 전 사용하는 목 구현체 — 메모리에서만 변경된다.
class MockNotificationRepository implements NotificationRepository {
  static const pageSize = 5;
  static final _start = DateTime(2026, 9, 7, 14, 22);

  static final _templates = [
    NotificationModel(
      id: 0,
      status: NotificationStatus.returned,
      title: '우산 #01',
      message: '우산 #01을 성공적으로 반납했어요!',
      date: _start,
      endDate: _start.add(const Duration(days: 1, hours: 2, minutes: 30)),
    ),
    NotificationModel(
      id: 0,
      status: NotificationStatus.overdue,
      title: '우산 #01',
      message: '우산 #01의 반납을 3시간 동안 지체했어요.\n패널티 ... 를 받을 예정이에요.',
      date: _start,
      endDate: _start.add(const Duration(days: 3, hours: 3)),
      overdue: const Duration(hours: 3),
    ),
    NotificationModel(
      id: 0,
      status: NotificationStatus.service,
      title: '서비스 안내',
      message: '서비스 안내 내용 ...',
      date: _start,
    ),
    NotificationModel(
      id: 0,
      status: NotificationStatus.inquiry,
      title: '문의 접수',
      message: '문의 접수가 성공적으로 완료되었어요!\n좀 더 나은 서비스를 제공하기 위해 노력할게요.',
      date: _start,
    ),
  ];

  /// 템플릿을 순환하며 12개 생성, 앞의 2개만 미확인
  final List<NotificationModel> _items = [
    for (var i = 0; i < 12; i++)
      _templates[i % _templates.length].copyWith(id: i + 1, read: i >= 2),
  ];

  bool _allowed = true;

  @override
  Future<NotificationPage> fetchNotifications({required int page}) async {
    final lastPage = max(1, (_items.length / pageSize).ceil());
    final current = page.clamp(1, lastPage);
    final from = (current - 1) * pageSize;

    return NotificationPage(
      items: _items.sublist(from, min(from + pageSize, _items.length)),
      page: current,
      lastPage: lastPage,
      total: _items.length,
      unread: _items.where((e) => !e.read).length,
    );
  }

  @override
  Future<void> readAll() async {
    _items.replaceRange(0, _items.length, [
      for (final e in _items) e.copyWith(read: true),
    ]);
  }

  @override
  Future<void> deleteRead() async => _items.removeWhere((e) => e.read);

  @override
  Future<bool> fetchAllowed() async => _allowed;

  @override
  Future<void> updateAllowed(bool allowed) async => _allowed = allowed;
}
