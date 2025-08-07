import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class AccountManagementWidget extends StatelessWidget {
  final Map<String, dynamic> userData;

  const AccountManagementWidget({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'account_circle',
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3.w),
                Text(
                  'Account & Support',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),

          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
          ),

          // Account Settings
          _buildAccountItem(
            context,
            'Change Password',
            'Update your account password',
            'lock',
            () {
              // Navigate to password change
              HapticFeedback.lightImpact();
            },
          ),

          _buildAccountItem(
            context,
            'Email Preferences',
            'Manage your email notifications',
            'email',
            () {
              // Navigate to email preferences
              HapticFeedback.lightImpact();
            },
          ),

          if (userData['membershipStatus'] == 'Premium')
            _buildAccountItem(
              context,
              'Subscription Details',
              'Manage your premium subscription',
              'card_membership',
              () {
                // Navigate to subscription management
                HapticFeedback.lightImpact();
              },
            ),

          // Divider
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
          ),

          // Support Section
          _buildAccountItem(
            context,
            'Help & FAQ',
            'Get answers to common questions',
            'help',
            () {
              // Open FAQ
              HapticFeedback.lightImpact();
            },
          ),

          _buildAccountItem(
            context,
            'Contact Support',
            'Get help from our support team',
            'support_agent',
            () {
              // Open contact support
              HapticFeedback.lightImpact();
            },
          ),

          _buildAccountItem(
            context,
            'Data Usage',
            'View your data consumption statistics',
            'data_usage',
            () {
              // Show data usage stats
              HapticFeedback.lightImpact();
            },
          ),

          // App Info
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1,
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.1),
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SleepWise',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          'Version 1.0.0 (Build 100)',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Rate app
                            HapticFeedback.lightImpact();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CustomIconWidget(
                                  iconName: 'star',
                                  color: Color(0xFFFFD700),
                                  size: 16,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  'Rate App',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem(
    BuildContext context,
    String title,
    String subtitle,
    String iconName,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            CustomIconWidget(
              iconName: 'chevron_right',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
