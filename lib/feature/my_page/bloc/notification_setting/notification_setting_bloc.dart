import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/feature/my_page/data/repositories/notification_repository.dart';

part 'notification_setting_event.dart';
part 'notification_setting_state.dart';

class NotificationSettingBloc
    extends Bloc<NotificationSettingEvent, NotificationSettingState> {
  NotificationSettingBloc({required this._notificationRepository})
    : super(const NotificationSettingState()) {
    on<NotificationSettingStarted>((e, emit) async {
      emit(
        NotificationSettingState(
          allowed: await _notificationRepository.fetchAllowed(),
        ),
      );
    });
    on<NotificationSettingChanged>((e, emit) async {
      if (e.allowed == state.allowed) return;
      final previous = state.allowed;
      emit(NotificationSettingState(allowed: e.allowed));
      try {
        await _notificationRepository.updateAllowed(e.allowed);
      } catch (_) {
        // 저장 실패 시 이전 값으로 되돌림
        emit(NotificationSettingState(allowed: previous));
      }
    });
  }

  final NotificationRepository _notificationRepository;
}
