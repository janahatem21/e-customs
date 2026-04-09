import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';
import 'widgets/password_strength_card.dart';
import 'widgets/register_footer.dart';
import 'widgets/register_header.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool agreeToTerms = false;
  bool isSubmitted = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fullNameController.addListener(_refresh);
    emailController.addListener(_refresh);
    passwordController.addListener(_refresh);
    confirmPasswordController.addListener(_refresh);
  }

  void _refresh() {
    setState(() {});
  }

  @override
  void dispose() {
    fullNameController.removeListener(_refresh);
    emailController.removeListener(_refresh);
    passwordController.removeListener(_refresh);
    confirmPasswordController.removeListener(_refresh);

    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String get fullName => fullNameController.text.trim();
  String get email => emailController.text.trim();
  String get password => passwordController.text;
  String get confirmPassword => confirmPasswordController.text;

  bool get hasMinLength => password.length >= 8;
  bool get hasSpecialChar =>
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(password);
  bool get hasNumber => RegExp(r'[0-9]').hasMatch(password);

  String? get fullNameError {
    if (!isSubmitted && fullName.isEmpty) return null;
    if (fullName.isEmpty) return 'Full name is required';
    if (fullName.length < 3) return 'Full name is too short';
    return null;
  }

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
    if (!hasMinLength ||
        !hasSpecialChar ||
        !hasUppercase ||
        !hasNumber) {
      return 'Password does not meet security requirements';
    }
    return null;
  }

  String? get confirmPasswordError {
    if (!isSubmitted && confirmPassword.isEmpty) return null;
    if (confirmPassword.isEmpty) return 'Please confirm your password';
    if (confirmPassword != password) return 'Passwords do not match';
    return null;
  }

  bool get isFormValid {
    return fullNameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        agreeToTerms;
  }

  Future<void> submitRegister() async {
    setState(() {
      isSubmitted = true;
    });

    if (!isFormValid) {
      if (!agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You must agree to the terms first'),
          ),
        );
      }
      return;
    }

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

  void goToLogin() {
    Navigator.pushReplacementNamed(context, AppRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    final passwordsMatch =
        confirmPassword.isNotEmpty && confirmPassword == password;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.blackText,
            size: 18,
          ),
        ),
        title: const Text(
          AppStrings.createAccount,
          style: TextStyle(
            color: AppColors.blackText,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RegisterHeader(),
              const SizedBox(height: 24),
              AppInput(
                label: AppStrings.fullName,
                hintText: AppStrings.fullNameHint,
                keyboardType: TextInputType.text,
                controller: fullNameController,
                errorText: fullNameError,
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 18,
                  color: AppColors.subtitleColor,
                ),
              ),
              const SizedBox(height: 16),
              AppInput(
                label: AppStrings.emailAddress,
                hintText: AppStrings.registerEmailHint,
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
              AppInput(
                label: AppStrings.password,
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
              const SizedBox(height: 16),
              PasswordStrengthCard(
                password: passwordController.text,
              ),
              const SizedBox(height: 16),
              AppInput(
                label: AppStrings.confirmPassword,
                hintText: AppStrings.passwordHint,
                obscureText: obscureConfirmPassword,
                keyboardType: TextInputType.text,
                controller: confirmPasswordController,
                errorText: confirmPasswordError,
                prefixIcon: const Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: AppColors.subtitleColor,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword = !obscureConfirmPassword;
                    });
                  },
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 18,
                    color: AppColors.subtitleColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    passwordsMatch
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    size: 12,
                    color: passwordsMatch
                        ? Colors.green
                        : AppColors.subtitleColor,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      AppStrings.confirmPasswordNote,
                      style: TextStyle(
                        fontSize: 11,
                        color: passwordsMatch
                            ? AppColors.blackText
                            : AppColors.subtitleColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        agreeToTerms = !agreeToTerms;
                      });
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        color: agreeToTerms
                            ? AppColors.primary
                            : AppColors.white,
                        border: Border.all(
                          color: isSubmitted && !agreeToTerms
                              ? Colors.red
                              : AppColors.lightGrey,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: agreeToTerms
                          ? const Icon(
                        Icons.check,
                        size: 14,
                        color: AppColors.white,
                      )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppStrings.termsHighlight,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackText,
                            ),
                          ),
                          TextSpan(
                            text: AppStrings.termsDescription,
                            style: TextStyle(
                              color: AppColors.subtitleColor,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              if (isSubmitted && !agreeToTerms) ...[
                const SizedBox(height: 8),
                const Text(
                  'You must agree to the terms to continue',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              AppButton(
                text: AppStrings.registerAccount,
                onPressed: isFormValid ? submitRegister : submitRegister,
                isLoading: isLoading,
              ),
              const SizedBox(height: 20),
              RegisterFooter(
                onLoginInstead: goToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}