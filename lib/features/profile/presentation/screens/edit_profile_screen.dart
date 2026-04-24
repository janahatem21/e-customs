import 'package:e_customs/core/utils/app_dialogs.dart';
import 'package:e_customs/core/utils/app_validatior.dart';
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

  late String _initialName;
  late String _initialEmail;
  late String _initialId;

  // Local state notifier for "has changes" to avoid full screen setState
  final ValueNotifier<bool> _hasChangesNotifier = ValueNotifier<bool>(false);
  bool _isDiscarding = false;

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

    // Add listeners to track changes
    _nameController.addListener(_checkChanges);
    _emailController.addListener(_checkChanges);
    _idController.addListener(_checkChanges);
  }

  void _checkChanges() {
    final hasChanges = _nameController.text != _initialName ||
        _emailController.text != _initialEmail ||
        _idController.text != _initialId;
    _hasChangesNotifier.value = hasChanges;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _idController.dispose();
    _hasChangesNotifier.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (!_hasChangesNotifier.value || _isDiscarding) return true;

    final result = await AppDialogs.showDiscardDialog(context);

    if (result == true) {
      _isDiscarding = true;
    }
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _hasChangesNotifier,
      builder: (context, hasChanges, _) {
        return PopScope(
          canPop: !hasChanges || _isDiscarding,
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
                  if (!hasChanges || _isDiscarding) {
                    Navigator.pop(context);
                    return;
                  }
                  final shouldPop = await _onWillPop();
                  if (shouldPop && mounted) Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.blackText,
                  size: 20,
                ),
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
                      prefixIcon: const Icon(
                        IconsaxPlusLinear.user,
                        size: 20,
                        color: AppColors.greyText,
                      ),
                      validator: AppValidator.validateName,
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 100.ms)
                        .slideX(begin: 0.1, end: 0),
                    const SizedBox(height: 20),
                    AppInput(
                      label: 'Passport Number / National ID',
                      controller: _idController,
                      hintText: 'Enter your ID number',
                      prefixIcon: const Icon(
                        IconsaxPlusLinear.card,
                        size: 20,
                        color: AppColors.greyText,
                      ),
                      validator: AppValidator.validateId,
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 200.ms)
                        .slideX(begin: 0.1, end: 0),
                    const SizedBox(height: 20),
                    AppInput(
                      label: 'Email Address',
                      controller: _emailController,
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        IconsaxPlusLinear.sms,
                        size: 20,
                        color: AppColors.greyText,
                      ),
                      validator: AppValidator.validateEmail,
                    )
                        .animate()
                        .fadeIn(duration: 400.ms, delay: 300.ms)
                        .slideX(begin: 0.1, end: 0),
                    const SizedBox(height: 40),
                    Consumer<ProfileProvider>(
                      builder: (context, provider, _) {
                        return AppButton(
                          text: provider.isSaving
                              ? 'Saving Changes...'
                              : 'Save Changes',
                          isLoading: provider.isSaving,
                          onPressed: (hasChanges && !provider.isSaving)
                              ? () => _handleSave(context)
                              : null,
                        )
                            .animate(target: provider.shakeCounter > 0 ? 1 : 0)
                            .shake(duration: 500.ms, hz: 4)
                            .animate()
                            .fadeIn(duration: 400.ms, delay: 400.ms)
                            .slideY(begin: 0.2, end: 0);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleSave(BuildContext context) async {
    final provider = context.read<ProfileProvider>();
    if (!_formKey.currentState!.validate()) {
      provider.triggerShake();
      return;
    }

    final success = await provider.updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
    );

    if (success && mounted) {
      // Update initial values
      _initialName = _nameController.text;
      _initialEmail = _emailController.text;
      _initialId = _idController.text;
      _hasChangesNotifier.value = false;

      Navigator.pop(context);
      AppDialogs.showSuccessSnackBar(context, 'Profile updated successfully!');
    }
  }
}
