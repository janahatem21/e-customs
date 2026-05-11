import 'package:flutter/material.dart';
import 'package:e_customs/core/constants/app_colors.dart';
import 'package:e_customs/features/notifications/domain/entities/notification_entity.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:iconsax_plus/iconsax_plus.dart';

extension NotificationTypeHelpers on String {
  IconData get icon {
    final t = toLowerCase();
    if (t.contains('payment')) return IconsaxPlusLinear.wallet_check;
    if (t.contains('declaration')) return IconsaxPlusLinear.box;
    if (t.contains('qr')) return IconsaxPlusLinear.scan_barcode;
    if (t.contains('action_required')) return IconsaxPlusLinear.danger;
    return IconsaxPlusLinear.setting_2;
  }

  Color get color {
    final t = toLowerCase();
    if (t.contains('payment')) return AppColors.success;
    if (t.contains('declaration')) return AppColors.info;
    if (t.contains('qr')) return AppColors.primary;
    if (t.contains('action_required')) return AppColors.warning;
    return AppColors.primary;
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typeIcon = notification.type.icon;
    final typeColor = notification.type.color;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.lightGrey.withValues(alpha: 0.5),
              width: notification.isRead ? 1 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Highlight Bar for unread
                if (!notification.isRead)
                  Container(width: 6, color: AppColors.primary),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon Container
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: typeColor.withValues(
                              alpha: notification.isRead ? 0.08 : 0.12,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            typeIcon,
                            color: typeColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      notification.title,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            fontWeight:
                                                notification.isRead
                                                    ? FontWeight.w600
                                                    : FontWeight.w800,
                                            fontSize: 16,
                                            color: AppColors.blackText,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    timeago
                                        .format(notification.createdAt)
                                        .toUpperCase(),
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.subtitleColor,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  if (!notification.isRead) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.blackText,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                notification.body,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  height: 1.5,
                                  color:
                                      notification.isRead
                                          ? AppColors.subtitleColor
                                          : AppColors.blackText.withValues(
                                            alpha: 0.7,
                                          ),
                                  fontWeight:
                                      notification.isRead
                                          ? FontWeight.normal
                                          : FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
