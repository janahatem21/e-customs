import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/app_validatior.dart';
import '../../../../core/widgets/app_input.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                        Icons.lock_reset_rounded,
                        size: 80,
                        color: AppColors.primary,
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        curve: Curves.easeOutBack,
                      ),
                  const SizedBox(height: 32),
                  Text(
                    'Forgot Password?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ).animate().fadeIn(delay: 100.ms, duration: 600.ms),
                  const SizedBox(height: 12),
                  Text(
                    'Don\'t worry! It happens. Please enter the email address associated with your account.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
                  const SizedBox(height: 48),
                  const AppInput(
                        label: 'Email Address',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(
                          Icons.alternate_email_rounded,
                          size: 20,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidator.validateEmail,
                      )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 600.ms)
                      .slideY(begin: 0.05, end: 0),
                  const SizedBox(height: 32),
                  ElevatedButton(
                        onPressed:
                            authProvider.isLoading
                                ? null
                                : () async {
                                  if (_formKey.currentState!.validate()) {
                                    await authProvider.forgotPassword(
                                      'test@test.com',
                                    );
                                    if (context.mounted) Navigator.pop(context);
                                  }
                                },
                        child:
                            authProvider.isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                : const Text('Send Reset Link'),
                      )
                      .animate(
                        onPlay:
                            (controller) => controller.repeat(reverse: true),
                      )
                      .shimmer(
                        delay: 2000.ms,
                        duration: 1500.ms,
                        color: Colors.white24,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
