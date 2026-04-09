import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  bool isSubmitted = false;
  bool isLoading = false;

  String get email => emailController.text.trim();

  String? get emailError {
    if (!isSubmitted && email.isEmpty) return null;
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  Future<void> sendReset() async {
    setState(() {
      isSubmitted = true;
    });

    if (emailError != null) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reset link sent to your email'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: AppColors.blackText),
        ),
        iconTheme: const IconThemeData(color: AppColors.blackText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Enter your email to receive a password reset link.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.subtitleColor,
              ),
            ),
            const SizedBox(height: 24),
            AppInput(
              label: 'Email',
              hintText: 'example@email.com',
              controller: emailController,
              errorText: emailError,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Send Reset Link',
              onPressed: sendReset,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}