import 'package:e_customs/core/providers/user_provider.dart';
import 'package:e_customs/features/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';

class HomeGreetingSection extends StatelessWidget {
  const HomeGreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final user = userProvider.user;
          final displayName = user?.name ?? 'User';

          return Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    context.read<HomeProvider>().getGreeting(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.greyText,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$displayName 👋',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackText,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
