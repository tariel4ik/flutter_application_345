import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/get_notifications_use_case.dart';
import '../../domain/usecases/watch_notifications_use_case.dart';


class NotificationsProvider with ChangeNotifier {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final WatchNotificationsUseCase _watchNotificationsUseCase;

  List<NotificationEntity> _notifications = [];
  Failure? _failure;
  bool _isLoading = false;

  StreamSubscription<Either<Failure, List<NotificationEntity>>>? _notifSub;

  NotificationsProvider({
    required GetNotificationsUseCase getNotificationsUseCase,
    required WatchNotificationsUseCase watchNotificationsUseCase,
  })  : _getNotificationsUseCase = getNotificationsUseCase,
        _watchNotificationsUseCase = watchNotificationsUseCase {
    _loadNotifications();
    _subscribeToNotificationsStream();
  }

  List<NotificationEntity> get notifications => _notifications;
  Failure? get failure => _failure;
  bool get isLoading => _isLoading;

  @override
  void dispose() {
    _notifSub?.cancel();
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    _setLoading(true);
    final result = await _getNotificationsUseCase.call();
    result.fold(
      (failure) {
        _failure = failure;
        _notifications = [];
      },
      (data) {
        _notifications = data;
        _failure = null;
      },
    );
    _setLoading(false);
  }

  void _subscribeToNotificationsStream() {
    _notifSub = _watchNotificationsUseCase().listen((either) {
      either.match(
        (failure) {
          _failure = failure;
          _notifications = [];
        },
        (newItems) {
          _notifications = newItems;
          _failure = null;
        },
      );
      notifyListeners();
    });
  }

  void clearError() {
    _failure = null;
    notifyListeners();
  }

  void reset() {
    _notifSub?.cancel();
    _notifSub = null;
    _notifications = [];
    _failure = null;
    _isLoading = false;
    _subscribeToNotificationsStream();
    notifyListeners();
  }

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void removeNotification(NotificationEntity notif) {
    notifications.remove(notif);
    notifyListeners();
  }
}
