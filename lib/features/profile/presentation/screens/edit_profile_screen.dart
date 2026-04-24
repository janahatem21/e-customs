import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/core/widgets/app_button.dart';
import 'package:e_customs/core/widgets/app_input.dart';
import 'package:e_customs/features/profile/presentation/provider/profile_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _idController;
  bool _isSaving = false;
  bool _isDiscarding = false;
  late String _initialName;
  late String _initialEmail;
  late String _initialId;

  // Animation controller for the shake effect
  double _shakeOffset = 0;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ProfileProvider>();
    _initialName = provider.userName;
    _initialEmail = provider.userEmail;
    _initialId = 'P123456789'; // Mock ID

    _nameController = TextEditingController(text: _initialName);
    _emailController = TextEditingController(text: _initialEmail);
    _idController = TextEditingController(text: _initialId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    super.dispose();
  }

  bool get _hasChanges {
    return _nameController.text != _initialName ||
        _emailController.text != _initialEmail ||
        _idController.text != _initialId;
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges || _isDiscarding) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Discard changes?',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('You have unsaved changes. Are you sure you want to discard them?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(color: AppColors.greyText)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (result == true) {
      _isDiscarding = true;
    }
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges || _isDiscarding,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.gradientTop,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              if (!_hasChanges || _isDiscarding) {
                Navigator.pop(context);
                return;
              }
              final shouldPop = await _onWillPop();
              if (shouldPop && mounted) Navigator.pop(context);
            },
            icon: const Icon(IconsaxPlusLinear.arrow_left, color: AppColors.blackText),
          ),
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              color: AppColors.blackText,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppInput(
                  label: 'Full Name',
                  controller: _nameController,
                  hintText: 'Enter your full name',
                  autofocus: true,
                  prefixIcon: const Icon(IconsaxPlusLinear.user, size: 20, color: AppColors.greyText),
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 3) {
                      return 'Name is too short';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppInput(
                  label: 'Passport Number / National ID',
                  controller: _idController,
                  hintText: 'Enter your ID number',
                  prefixIcon: const Icon(IconsaxPlusLinear.card, size: 20, color: AppColors.greyText),
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 8) {
                      return 'Invalid ID format';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                AppInput(
                  label: 'Email Address',
                  controller: _emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(IconsaxPlusLinear.sms, size: 20, color: AppColors.greyText),
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: _shakeOffset),
                  duration: const Duration(milliseconds: 500),
                  builder: (context, offset, child) {
                    return Transform.translate(
                      offset: Offset(offset, 0),
                      child: child,
                    );
                  },
                  onEnd: () => setState(() => _shakeOffset = 0),
                  child: AppButton(
                    text: _isSaving ? 'Saving Changes...' : 'Save Changes',
                    isLoading: _isSaving,
                    onPressed: (_hasChanges && !_isSaving) ? _handleSave : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      // Trigger shake effect
      setState(() => _shakeOffset = 10.0);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors before saving'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.read<ProfileProvider>().updateProfile(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
        );
        setState(() => _isSaving = false);
        
        // Update initial values so we can pop without dialog
        _initialName = _nameController.text;
        _initialEmail = _emailController.text;
        _initialId = _idController.text;

        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(IconsaxPlusBold.tick_circle, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text('Profile updated successfully!'),
              ],
            ),
            backgroundColor: AppColors.primary,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),
          ),
        );
      }
    });
  }
}
