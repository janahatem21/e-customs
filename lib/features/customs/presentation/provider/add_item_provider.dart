import 'package:e_customs/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/usecases/add_item_usecase.dart';

enum AddItemState { idle, loading, success, error }

@injectable
class AddItemProvider extends ChangeNotifier {
  final AddItemsUseCase _addItemsUseCase;
  AddItemProvider(this._addItemsUseCase);

  final PageController pageController = PageController();
  int _currentStep = 0;

  // Form Fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? _selectedCategory;
  String _selectedCurrency = 'USD';
  int _quantity = 1;

  // Multiple Items State
  final List<ItemEntity> _pendingItems = [];

  // State Management
  AddItemState _state = AddItemState.idle;
  String? _errorMessage;

  final List<String> categories = AppConstants.categories;
  final List<String> currencies = AppConstants.currencies;

  // Getters
  int get currentStep => _currentStep;
  String? get selectedCategory => _selectedCategory;
  String get selectedCurrency => _selectedCurrency;
  int get quantity => _quantity;
  AddItemState get state => _state;
  bool get isLoading => _state == AddItemState.loading;
  bool get isSuccess => _state == AddItemState.success;
  String? get errorMessage => _errorMessage;
  List<ItemEntity> get pendingItems => List.unmodifiable(_pendingItems);

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuart,
      );
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuart,
      );
      notifyListeners();
    }
  }

  void setCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  void incrementQuantity() {
    _quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void addItemToList() {
    if (!_validateInput()) return;

    final item = ItemEntity(
      name: nameController.text.trim(),
      category: _selectedCategory!,
      price: double.parse(priceController.text.trim()),
      quantity: _quantity,
      currency: _selectedCurrency,
      isExempted: false,
    );

    _pendingItems.add(item);
    _clearForm();
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _pendingItems.length) {
      _pendingItems.removeAt(index);
      notifyListeners();
    }
  }

  void updateItem(int index, ItemEntity item) {
    if (index >= 0 && index < _pendingItems.length) {
      _pendingItems[index] = item;
      notifyListeners();
    }
  }

  void _clearForm() {
    nameController.clear();
    priceController.clear();
    _selectedCategory = null;
    _selectedCurrency = 'USD';
    _quantity = 1;
    _currentStep = 0;
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
  }

  String getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Product Information';
      case 1:
        return 'Pricing Details';
      case 2:
        return 'Review Item';
      default:
        return '';
    }
  }

  Future<void> saveAllItems({
    required String userId,
    required String declarationId,
  }) async {
    if (_pendingItems.isEmpty) {
      _setError('Please add at least one item');
      return;
    }

    _state = AddItemState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      await _addItemsUseCase(
        AddItemsParams(
          userId: userId,
          declarationId: declarationId,
          items: _pendingItems,
        ),
      );

      _state = AddItemState.success;
      _pendingItems.clear();
      notifyListeners();
    } catch (e) {
      _state = AddItemState.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  bool _validateInput() {
    if (nameController.text.trim().isEmpty) {
      _setError('Please enter product name');
      return false;
    }
    if (_selectedCategory == null) {
      _setError('Please select a category');
      return false;
    }
    if (priceController.text.trim().isEmpty) {
      _setError('Please enter price');
      return false;
    }
    if (double.tryParse(priceController.text.trim()) == null) {
      _setError('Please enter a valid price');
      return false;
    }
    return true;
  }

  void _setError(String message) {
    _state = AddItemState.error;
    _errorMessage = message;
    notifyListeners();
  }

  void resetState() {
    _state = AddItemState.idle;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
