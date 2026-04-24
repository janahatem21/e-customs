// ignore_for_file: use_build_context_synchronously

import 'package:e_customs/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_strings.dart';
import '../../../../../../core/routes/app_router.dart';
import '../../../../../../core/utils/app_validatior.dart';
import '../../../../../../core/widgets/app_input.dart';
import '../../../providers/auth_provider.dart';
import '../widgets/login_header.dart';
import '../widgets/social_login_buttons.dart';
import '../widgets/signup_prompt.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientTop, Colors.white],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 1),
                      const LoginHeader()
                          .animate()
                          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                          .slideY(begin: 0.05, end: 0),
                      const SizedBox(height: 48),
                      const _LoginForm()
                          .animate(delay: 150.ms)
                          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                          .slideY(begin: 0.05, end: 0),
                      const Spacer(flex: 2),
                      const SocialLoginButtons()
                          .animate(delay: 300.ms)
                          .fadeIn(duration: 600.ms),
                      const SizedBox(height: 32),
                      const SignUpPrompt()
                          .animate(delay: 450.ms)
                          .fadeIn(duration: 600.ms),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
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
            label: AppStrings.emailAddress,
            hintText: AppStrings.emailHint,
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
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed:
                  () => Navigator.pushNamed(context, AppRouter.forgotPassword),
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              child: const Text(
                AppStrings.forgotPassword,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ),
          ),
          const SizedBox(height: 24),
          AppButton(
            text: AppStrings.signIn,
            isLoading: authProvider.isLoading,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await authProvider.login(
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
