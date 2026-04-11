import 'package:flutter/material.dart';
import 'package:e_customs/features/notifications/data/entities/notification_entity.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationEntity> _notifications = [];
  
  NotificationType? _selectedType;
  NotificationType? get selectedType => _selectedType;

  List<NotificationEntity> get notifications {
    if (_selectedType == null) return _notifications;
    return _notifications.where((n) => n.type == _selectedType).toList();
  }

  void setFilter(NotificationType? type) {
    _selectedType = type;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  NotificationProvider() {
    _loadNotifications();
  }

  void _loadNotifications() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    _notifications = List.from(NotificationEntity.dummyNotifications);
    
    _isLoading = false;
    notifyListeners();
  }

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1 && !_notifications[index].isRead) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void markAllAsRead() {
    bool changed = false;
    for (var notification in _notifications) {
      if (!notification.isRead) {
        notification.isRead = true;
        changed = true;
      }
    }
    if (changed) {
      notifyListeners();
    }
  }

  void deleteNotification(String id) {
    _notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  int get unreadCount => _notifications.where((n) => !n.isRead).length;
}
