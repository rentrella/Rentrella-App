import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/core/enum/load_status.dart';
import 'package:rentrella/feature/my_page/data/models/notification_model.dart';
import 'package:rentrella/feature/my_page/data/repositories/notification_repository.dart';

part 'notification_history_event.dart';
part 'notification_history_state.dart';

class NotificationHistoryBloc
    extends Bloc<NotificationHistoryEvent, NotificationHistoryState> {
  NotificationHistoryBloc({required this._notificationRepository})
    : super(const NotificationHistoryState()) {
    on<NotificationHistoryStarted>((e, emit) => _load(emit, page: 1));
    on<NotificationHistoryPageChanged>((e, emit) => _load(emit, page: e.page));
    on<NotificationHistoryReadAllRequested>((e, emit) async {
      await _notificationRepository.readAll();
      await _load(emit, page: state.page);
    });
    on<NotificationHistoryDeleteReadRequested>((e, emit) async {
      await _notificationRepository.deleteRead();
      await _load(emit, page: state.page);
    });
  }

  final NotificationRepository _notificationRepository;

  Future<void> _load(
    Emitter<NotificationHistoryState> emit, {
    required int page,
  }) async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final result = await _notificationRepository.fetchNotifications(
        page: page,
      );
      emit(state.withPage(result));
    } catch (_) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }
}
