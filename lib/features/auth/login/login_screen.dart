import 'package:e_customs/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isSubmitted = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_refresh);
    passwordController.addListener(_refresh);
  }

  void _refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    emailController.removeListener(_refresh);
    passwordController.removeListener(_refresh);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String get email => emailController.text.trim();
  String get password => passwordController.text;

  String? get emailError {
    if (!isSubmitted && email.isEmpty) return null;
    if (email.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? get passwordError {
    if (!isSubmitted && password.isEmpty) return null;
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  bool get isFormValid {
    return emailError == null && passwordError == null;
  }

  Future<void> submitLogin() async {
    setState(() {
      isSubmitted = true;
    });

    if (!isFormValid) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    Navigator.pushReplacementNamed(context, AppRouter.home);
  }

  void goToRegister() {
    Navigator.pushNamed(context, AppRouter.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.shield_outlined,
                            size: 28,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          AppStrings.welcomeBack,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          AppStrings.loginSubtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.subtitleColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    AppInput(
                      label: AppStrings.emailAddress,
                      hintText: AppStrings.emailHint,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      errorText: emailError,
                      prefixIcon: const Icon(
                        Icons.mail_outline,
                        size: 18,
                        color: AppColors.subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 6,
                      children: [
                        const Text(
                          AppStrings.password,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackText,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouter.forgotPassword);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            AppStrings.forgotPassword,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    AppInput(
                      hintText: AppStrings.passwordHint,
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.text,
                      controller: passwordController,
                      errorText: passwordError,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        size: 18,
                        color: AppColors.subtitleColor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 18,
                          color: AppColors.subtitleColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      text: AppStrings.signIn,
                      onPressed: submitLogin,
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.lightGrey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            AppStrings.orContinueWith,
                            style: TextStyle(
                              fontSize: 11,
                              letterSpacing: 1,
                              color: AppColors.subtitleColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: AppStrings.google,
                            variant: AppButtonVariant.outline,
                            onPressed: () {},
                            leadingIcon: Image.asset(
                              AppAssets.googleLogo,
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            text: AppStrings.github,
                            variant: AppButtonVariant.outline,
                            onPressed: () {},
                            leadingIcon: Image.asset(
                              AppAssets.githubLogo,
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            AppStrings.secureEncryption,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              letterSpacing: 1,
                              color: AppColors.subtitleColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: goToRegister,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: AppStrings.noAccount,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.subtitleColor,
                        ),
                        children: [
                          TextSpan(
                            text: AppStrings.signUpNow,
                            style: TextStyle(
                              color: AppColors.blackText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}