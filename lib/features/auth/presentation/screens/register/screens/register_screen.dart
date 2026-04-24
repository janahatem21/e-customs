// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/routes/app_router.dart';
import '../../../../../../core/utils/app_validatior.dart';
import '../../../../../../core/widgets/app_input.dart';
import '../../../providers/auth_provider.dart';
import '../widgets/password_strength_card.dart';
import '../widgets/register_footer.dart';
import '../widgets/register_header.dart';
import '../../../../../../core/widgets/app_button.dart';
import '../widgets/terms_checkbox.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientTop, Colors.white],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 20),
                    const RegisterHeader()
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .scale(
                          begin: const Offset(0.95, 0.95),
                          curve: Curves.easeOut,
                        ),
                    const SizedBox(height: 40),
                    const _RegisterForm()
                        .animate(delay: 100.ms)
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.05, end: 0),
                    const SizedBox(height: 32),
                    const RegisterFooter()
                        .animate(delay: 300.ms)
                        .fadeIn(duration: 600.ms),
                    const SizedBox(height: 24),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppInput(
            label: AppStrings.fullName,
            hintText: AppStrings.fullNameHint,
            controller: _nameController,
            prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
            validator: AppValidator.validateName,
          ),
          const SizedBox(height: 20),
          AppInput(
            label: AppStrings.emailAddress,
            hintText: AppStrings.registerEmailHint,
            controller: _emailController,
            prefixIcon: const Icon(Icons.alternate_email_rounded, size: 20),
            keyboardType: TextInputType.emailAddress,
            validator: AppValidator.validateEmail,
          ),
          const SizedBox(height: 20),
          AppInput(
            label: AppStrings.password,
            hintText: AppStrings.passwordHint,
            controller: _passwordController,
            obscureText: authProvider.obscurePassword,
            prefixIcon: const Icon(Icons.lock_person_outlined, size: 20),
            validator: AppValidator.validatePassword,
            suffixIcon: IconButton(
              onPressed: authProvider.togglePasswordVisibility,
              icon: Icon(
                authProvider.obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ValueListenableBuilder(
            valueListenable: _passwordController,
            builder: (context, value, child) {
              return PasswordStrengthCard(password: value.text);
            },
          ),
          const SizedBox(height: 20),
          AppInput(
            label: AppStrings.confirmPassword,
            hintText: AppStrings.passwordHint,
            obscureText: authProvider.obscureConfirmPassword,
            prefixIcon: const Icon(Icons.verified_user_outlined, size: 20),
            validator:
                (value) => AppValidator.validateConfirmPassword(
                  value,
                  _passwordController.text,
                ),
            suffixIcon: IconButton(
              onPressed: authProvider.toggleConfirmPasswordVisibility,
              icon: Icon(
                authProvider.obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const TermsCheckbox(),
          const SizedBox(height: 32),
          AppButton(
            text: AppStrings.registerAccount,
            isLoading: authProvider.isLoading,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (!authProvider.agreeToTerms) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please agree to terms and conditions'),
                    ),
                  );
                  return;
                }

                try {
                  await authProvider.register(
                    _nameController.text.trim(),
                    _emailController.text.trim(),
                    _passwordController.text,
                  );
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, AppRouter.layout);
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              }
            },
            shimmer: true,
          ),
        ],
      ),
    );
  }
}
