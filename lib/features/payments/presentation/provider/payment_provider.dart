import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/fee_entity.dart';
import '../../domain/entities/payment_result_entity.dart';
import '../../domain/usecases/complete_payment_usecase.dart';
import '../../../customs/domain/entities/declaration_entity.dart';
import '../../../customs/domain/repositories/declarations_repository.dart';
import '../../../../core/services/notification_service.dart';

enum AppPaymentMethod { card, wallet }

@injectable
class PaymentProvider extends ChangeNotifier {
  final CompletePaymentUseCase _completePaymentUseCase;
  final DeclarationsRepository _declarationsRepository;
  final NotificationService _notificationService;

  PaymentProvider(
    this._completePaymentUseCase,
    this._declarationsRepository,
    this._notificationService,
  );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Fees / Summary Information
  String? _declarationId;
  String _shipmentId = "EC-CUSTOMS";
  double _totalAmount = 0.0;
  String _currency = "USD";
  List<FeeEntity> _breakdown = [];

  // Payment State
  bool _isLoading = false;
  bool _isInitialLoading = false;
  String? _errorMessage;
  PaymentResultEntity? _paymentResult;
  AppPaymentMethod _selectedMethod = AppPaymentMethod.card;

  // Card Info
  String _cardHolderName = "";
  String _cardNumber = "";
  String _expiryDate = "";
  String _cvv = "";

  // Wallet Info
  String _phoneNumber = "";

  // Getters
  bool get isLoading => _isLoading;
  bool get isInitialLoading => _isInitialLoading;
  String? get errorMessage => _errorMessage;
  PaymentResultEntity? get paymentResult => _paymentResult;
  AppPaymentMethod get selectedMethod => _selectedMethod;

  String? get declarationId => _declarationId;
  String get shipmentId => _shipmentId;
  double get totalAmount => _totalAmount;
  String get currency => _currency;
  List<FeeEntity> get breakdown => _breakdown;

  String get cardHolderName => _cardHolderName;
  String get cardNumber => _cardNumber;
  String get expiryDate => _expiryDate;
  String get cvv => _cvv;
  String get phoneNumber => _phoneNumber;

  void initFromDeclaration(DeclarationEntity declaration) {
    _shipmentId = declaration.id?.substring(0, 8).toUpperCase() ?? "EC-CUSTOMS";
    _totalAmount = declaration.totalAmount;
    _currency = "USD";

    _breakdown = [
      FeeEntity(
        title: "Customs Fees",
        description: "Calculated based on item categories",
        amount: declaration.totalCustoms,
        icon: Icons.balance_rounded,
      ),
      FeeEntity(
        title: "Value Added Tax (VAT)",
        description: "Standard rate applied (14%)",
        amount: declaration.totalVAT,
        icon: Icons.percent_rounded,
      ),
      FeeEntity(
        title: "Admin & Processing",
        description: "Fixed handling fee",
        amount: 0.0,
        icon: Icons.assignment_outlined,
      ),
    ];
    notifyListeners();
  }

  // Setters
  void setPaymentMethod(AppPaymentMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }

  void updateCardHolderName(String value) {
    _cardHolderName = value;
    notifyListeners();
  }

  void updateCardNumber(String value) {
    _cardNumber = value;
    notifyListeners();
  }

  void updateExpiryDate(String value) {
    _expiryDate = value;
    notifyListeners();
  }

  void updateCvv(String value) {
    _cvv = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  Future<void> getDeclaration({
    required String userId,
    required String declarationId,
  }) async {
    _isInitialLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final declaration = await _declarationsRepository.getDeclarationById(
        userId,
        declarationId,
      );
      if (declaration != null) {
        _declarationId = declarationId;
        initFromDeclaration(declaration);
      } else {
        _errorMessage = "Declaration not found";
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isInitialLoading = false;
      notifyListeners();
    }
  }

  Future<bool> pay({
    required String userId,
    required String declarationId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _paymentResult = null;
    notifyListeners();

    try {
      // Simulate bank delay
      await Future.delayed(const Duration(seconds: 2));

      final result = await _completePaymentUseCase(
        userId: userId,
        declarationId: declarationId,
      );

      _paymentResult = result;

      // Trigger Notifications
      await _notificationService.notifyPaymentSuccess(userId, declarationId);
      await _notificationService.notifyQRReady(userId, declarationId);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _paymentResult = null;
    _selectedMethod = AppPaymentMethod.card;
    _cardHolderName = "";
    _cardNumber = "";
    _expiryDate = "";
    _cvv = "";
    _phoneNumber = "";
    notifyListeners();
  }
}
