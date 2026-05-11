import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import '../../domain/usecases/mark_all_notifications_as_read_usecase.dart';
import '../../domain/usecases/mark_notification_as_read_usecase.dart';
import '../../domain/usecases/get_unread_notifications_count_usecase.dart';

@injectable
class NotificationsProvider extends ChangeNotifier {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkAllNotificationsAsReadUseCase _markAllNotificationsAsReadUseCase;
  final MarkNotificationAsReadUseCase _markNotificationAsReadUseCase;
  final GetUnreadNotificationsCountUseCase _getUnreadNotificationsCountUseCase;

  NotificationsProvider(
    this._getNotificationsUseCase,
    this._markAllNotificationsAsReadUseCase,
    this._markNotificationAsReadUseCase,
    this._getUnreadNotificationsCountUseCase,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<NotificationEntity> _notifications = [];
  String _selectedFilter = 'All';
  String get selectedFilter => _selectedFilter;

  int _unreadCount = 0;
  int get unreadCount => _unreadCount;

  StreamSubscription<List<NotificationEntity>>? _notificationsSub;
  StreamSubscription<int>? _unreadCountSub;

  List<NotificationEntity> get notifications => filteredNotifications;

  List<NotificationEntity> get filteredNotifications {
    if (_selectedFilter == 'All') return _notifications;

    return _notifications.where((n) {
      final type = n.type.toLowerCase();
      switch (_selectedFilter) {
        case 'Declarations':
          return type == 'declaration' ||
              type == 'action_required' ||
              type == 'qr';
        case 'Payments':
          return type == 'payment';
        case 'System':
          return type == 'system';
        default:
          return false;
      }
    }).toList();
  }

  @override
  void dispose() {
    _notificationsSub?.cancel();
    _unreadCountSub?.cancel();
    super.dispose();
  }

  void loadNotifications(String userId) {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Cancel existing subscriptions if any
    _notificationsSub?.cancel();
    _unreadCountSub?.cancel();

    // Listen to notifications stream
    _notificationsSub = _getNotificationsUseCase(userId).listen(
      (notifications) {
        _notifications = notifications;
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        _errorMessage = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );

    // Listen to unread count stream
    _unreadCountSub = _getUnreadNotificationsCountUseCase(userId).listen(
      (count) {
        _unreadCount = count;
        notifyListeners();
      },
      onError: (e) {
        debugPrint('Error listening to unread count: $e');
      },
    );
  }

  void changeFilter(String filter) {
    if (_selectedFilter == filter) return;
    _selectedFilter = filter;
    notifyListeners();
  }

  Future<void> markAllAsRead(String userId) async {
    if (_unreadCount == 0) return;

    try {
      await _markAllNotificationsAsReadUseCase(userId);
      // No need to manually update local state; Firestore Stream will push the update
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> markAsRead(String userId, String notificationId) async {
    try {
      await _markNotificationAsReadUseCase(userId, notificationId);
      // No need to manually update local state; Firestore Stream will push the update
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
