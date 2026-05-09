import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../history/domain/repositories/history_repository.dart';

@injectable
class HomeProvider extends ChangeNotifier {
  final HistoryRepository _historyRepository;
  HomeProvider(this._historyRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  double _totalPaidAmount = 0.0;
  int _paidCount = 0;
  int _pendingCount = 0;

  double get totalPaidAmount => _totalPaidAmount;
  int get paidCount => _paidCount;
  int get pendingCount => _pendingCount;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> fetchHomeStats(String userId) async {
    setLoading(true);
    try {
      final declarations = await _historyRepository.getDeclarations(userId);

      _totalPaidAmount = 0.0;
      _paidCount = 0;
      _pendingCount = 0;

      for (final dec in declarations) {
        if (dec.status == 'paid') {
          _totalPaidAmount += dec.totalAmount;
          _paidCount++;
        } else if (dec.status == 'calculated') {
          _pendingCount++;
        }
      }
    } catch (e) {
      debugPrint('Error fetching home stats: $e');
    } finally {
      setLoading(false);
    }
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,';
    if (hour < 17) return 'Good Afternoon,';
    return 'Good Evening,';
  }
}
