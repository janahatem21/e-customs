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

  Future<void> loadNotifications(String userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _getNotificationsUseCase(userId),
        _getUnreadNotificationsCountUseCase(userId),
      ]);

      _notifications = results[0] as List<NotificationEntity>;
      _unreadCount = results[1] as int;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
      // Update local state to avoid extra fetch if possible,
      // but simpler to just refresh or update locally
      _notifications =
          _notifications
              .map(
                (n) => NotificationEntity(
                  id: n.id,
                  title: n.title,
                  body: n.body,
                  type: n.type,
                  isRead: true,
                  createdAt: n.createdAt,
                  declarationId: n.declarationId,
                ),
              )
              .toList();
      _unreadCount = 0;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> markAsRead(String userId, String notificationId) async {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index == -1 || _notifications[index].isRead) return;

    try {
      await _markNotificationAsReadUseCase(userId, notificationId);

      final n = _notifications[index];
      final updatedNotification = NotificationEntity(
        id: n.id,
        title: n.title,
        body: n.body,
        type: n.type,
        isRead: true,
        createdAt: n.createdAt,
        declarationId: n.declarationId,
      );

      // Replace list with a new reference to trigger Selector/Provider updates
      _notifications = List<NotificationEntity>.from(_notifications);
      _notifications[index] = updatedNotification;

      if (_unreadCount > 0) _unreadCount--;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
