import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/feature/my_page/bloc/notification_history/notification_history_bloc.dart';
import 'package:rentrella/feature/my_page/bloc/notification_setting/notification_setting_bloc.dart';
import 'package:rentrella/feature/my_page/data/repositories/mock_notification_repository.dart';

void main() {
  group('NotificationHistoryBloc', () {
    NotificationHistoryBloc build() => NotificationHistoryBloc(
      notificationRepository: MockNotificationRepository(),
    );

    blocTest<NotificationHistoryBloc, NotificationHistoryState>(
      '첫 페이지를 불러온다',
      build: build,
      act: (bloc) => bloc.add(const NotificationHistoryStarted()),
      verify: (bloc) {
        final s = bloc.state;
        expect(s.page, 1);
        expect(s.lastPage, 3);
        expect(s.total, 12);
        expect(s.unread, 2);
        expect(s.items.length, MockNotificationRepository.pageSize);
        expect(s.hasPrev, isFalse);
        expect(s.hasNext, isTrue);
      },
    );

    blocTest<NotificationHistoryBloc, NotificationHistoryState>(
      '페이지를 넘긴다',
      build: build,
      act: (bloc) => bloc.add(const NotificationHistoryPageChanged(3)),
      verify: (bloc) {
        expect(bloc.state.page, 3);
        expect(bloc.state.items.length, 2);
      },
    );

    blocTest<NotificationHistoryBloc, NotificationHistoryState>(
      '전체 읽기 후 읽은 알림을 삭제하면 비어 있다',
      build: build,
      act: (bloc) => bloc
        ..add(const NotificationHistoryStarted())
        ..add(const NotificationHistoryReadAllRequested())
        ..add(const NotificationHistoryDeleteReadRequested()),
      verify: (bloc) {
        expect(bloc.state.unread, 0);
        expect(bloc.state.total, 0);
        expect(bloc.state.items, isEmpty);
      },
    );
  });

  blocTest<NotificationSettingBloc, NotificationSettingState>(
    '알림 설정을 변경한다',
    build: () => NotificationSettingBloc(
      notificationRepository: MockNotificationRepository(),
    ),
    act: (bloc) => bloc
      ..add(const NotificationSettingStarted())
      ..add(const NotificationSettingChanged(false)),
    verify: (bloc) => expect(bloc.state.allowed, isFalse),
  );
}
