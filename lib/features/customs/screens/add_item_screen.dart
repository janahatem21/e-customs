import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_input.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Form Fields
  final TextEditingController _nameController = TextEditingController();
  String? _selectedCategory;
  final TextEditingController _priceController = TextEditingController();
  String _selectedCurrency = 'USD';
  int _quantity = 1;

  final List<String> _categories = [
    'Mobile',
    'Laptop',
    'Clothing',
    'Electronics',
    'Cosmetics'
  ];

  final List<String> _currencies = ['USD', 'EUR', 'EGP'];

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
      _pageController.nextPage(
        duration: 400.ms,
        curve: Curves.easeInOutQuart,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _pageController.previousPage(
        duration: 400.ms,
        curve: Curves.easeInOutQuart,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gradientTop,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(IconsaxPlusLinear.arrow_left, color: AppColors.blackText),
        ),
        title: const Text(
          'Add New Item',
          style: TextStyle(
            color: AppColors.blackText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressIndicator(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildStep1(),
                  _buildStep2(),
                  _buildStep3(),
                ],
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              final isActive = index <= _currentStep;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index == 2 ? 0 : 8),
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : AppColors.lightGrey.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ).animate(target: isActive ? 1 : 0).tint(color: AppColors.primary),
              );
            }),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${_currentStep + 1} of 3',
                style: TextStyle(
                  color: AppColors.greyText,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _getStepTitle(),
                style: const TextStyle(
                  color: AppColors.blackText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getStepTitle() {
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

  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell us about the product',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          const SizedBox(height: 8),
          const Text(
            'Enter the basic details of the item you want to add to your declaration.',
            style: TextStyle(color: AppColors.greyText, fontSize: 14),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          AppInput(
            label: 'Product Name',
            hintText: 'e.g. iPhone 15 Pro',
            controller: _nameController,
            prefixIcon: const Icon(IconsaxPlusLinear.box, size: 20),
          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0),
          const SizedBox(height: 20),
          _buildDropdownLabel('Category'),
          _buildCategoryDropdown(),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Price & Quantity',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          const SizedBox(height: 8),
          const Text(
            'Specify the value and the amount of items.',
            style: TextStyle(color: AppColors.greyText, fontSize: 14),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: AppInput(
                  label: 'Price',
                  hintText: '0.00',
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(IconsaxPlusLinear.money_3, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDropdownLabel('Currency'),
                    _buildCurrencyDropdown(),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          const Text(
            'Quantity',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.blackText,
            ),
          ),
          const SizedBox(height: 12),
          _buildQuantityStepper(),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Review Details',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.blackText,
            ),
          ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          const SizedBox(height: 8),
          const Text(
            'Please check the information before adding the item.',
            style: TextStyle(color: AppColors.greyText, fontSize: 14),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
          const SizedBox(height: 32),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildSummaryRow('Product Name', _nameController.text),
                _buildSummaryDivider(),
                _buildSummaryRow('Category', _selectedCategory ?? 'Not selected'),
                _buildSummaryDivider(),
                _buildSummaryRow('Price', '${_priceController.text} $_selectedCurrency'),
                _buildSummaryDivider(),
                _buildSummaryRow('Quantity', _quantity.toString()),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.greyText, fontSize: 14)),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.blackText,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryDivider() {
    return Divider(color: AppColors.lightGrey.withValues(alpha: 0.3), height: 1);
  }

  Widget _buildDropdownLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.blackText,
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCategory,
          hint: const Text('Select category', style: TextStyle(color: AppColors.greyText, fontSize: 14)),
          isExpanded: true,
          icon: const Icon(IconsaxPlusLinear.arrow_down_1, size: 18),
          items: _categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category, style: const TextStyle(fontSize: 14, color: AppColors.blackText)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() => _selectedCategory = newValue);
          },
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildCurrencyDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 52, // Match AppInput height approximately
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCurrency,
          isExpanded: true,
          icon: const Icon(IconsaxPlusLinear.arrow_down_1, size: 18),
          items: _currencies.map((String currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(currency, style: const TextStyle(fontSize: 14, color: AppColors.blackText)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() => _selectedCurrency = newValue!);
          },
        ),
      ),
    );
  }

  Widget _buildQuantityStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildStepperButton(
            icon: IconsaxPlusLinear.minus,
            onTap: () {
              if (_quantity > 1) setState(() => _quantity--);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _quantity.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.blackText,
              ),
            ),
          ),
          _buildStepperButton(
            icon: IconsaxPlusLinear.add,
            onTap: () => setState(() => _quantity++),
            isPrimary: true,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildStepperButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.lightGrey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isPrimary ? AppColors.white : AppColors.blackText,
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (_currentStep > 0) ...[
            Expanded(
              child: AppButton(
                text: 'Back',
                variant: AppButtonVariant.outline,
                onPressed: _previousStep,
              ),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            flex: 2,
            child: AppButton(
              text: _currentStep == 2 ? 'Add Item' : 'Continue',
              onPressed: () {
                if (_currentStep == 2) {
                  // Final Action
                  Navigator.pop(context);
                } else {
                  _nextStep();
                }
              },
              trailingIcon: _currentStep == 2
                  ? const Icon(IconsaxPlusLinear.add_square, size: 20)
                  : const Icon(IconsaxPlusLinear.arrow_right_3, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
