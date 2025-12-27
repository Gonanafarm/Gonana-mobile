import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/notification_repository.dart';
import '../../../../core/models/notification_model.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository();
});

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, NotificationsState>((ref) {
  return NotificationsNotifier(ref.read(notificationRepositoryProvider));
});

class NotificationsState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? error;

  NotificationsState({
    this.notifications = const [],
    this.isLoading = false,
    this.error,
  });

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  NotificationsState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    String? error,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class NotificationsNotifier extends StateNotifier<NotificationsState> {
  final NotificationRepository _repository;

  NotificationsNotifier(this._repository) : super(NotificationsState()) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getNotifications();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (notifications) {
        state = state.copyWith(
          notifications: notifications,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  Future<bool> markAsRead(String notificationId) async {
    final result = await _repository.markAsRead(notificationId);

    return result.fold(
      (failure) => false,
      (success) {
        loadNotifications(); // Reload to update status
        return true;
      },
    );
  }

  Future<bool> markAllAsRead() async {
    final result = await _repository.markAllAsRead();

    return result.fold(
      (failure) => false,
      (success) {
        loadNotifications(); // Reload to update status
        return true;
      },
    );
  }

  Future<void> refresh() => loadNotifications();
}
