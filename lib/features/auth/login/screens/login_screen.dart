import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/app_validatior.dart';
import '../../../../core/widgets/app_input.dart';
import '../../providers/auth_provider.dart';
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
            colors: [
              AppColors.gradientTop,
              Colors.white,
            ],
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

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppInput(
            label: AppStrings.emailAddress,
            hintText: AppStrings.emailHint,
            prefixIcon: Icon(Icons.alternate_email_rounded, size: 20),
            keyboardType: TextInputType.emailAddress,
            validator: AppValidator.validateEmail,
          ),
          const SizedBox(height: 20),
          AppInput(
            label: AppStrings.password,
            hintText: AppStrings.passwordHint,
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
              onPressed: () => Navigator.pushNamed(context, AppRouter.forgotPassword),
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
          ElevatedButton(
            onPressed: authProvider.isLoading
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, AppRouter.home);
                    }
                  },
            child: authProvider.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.signIn),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .shimmer(delay: 2000.ms, duration: 1500.ms, color: Colors.white24),
        ],
      ),
    );
  }
}