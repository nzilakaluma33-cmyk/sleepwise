import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WelcomeActionsWidget extends StatelessWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onSkip;

  const WelcomeActionsWidget({
    super.key,
    required this.onGetStarted,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary action button
          SizedBox(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                onGetStarted();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                elevation: 2,
                shadowColor: Theme.of(context).shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get Started',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: 'arrow_forward',
                    size: 5.w > 20 ? 20 : 5.w,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Secondary action
          TextButton(
            onPressed: () {
              HapticFeedback.selectionClick();
              onSkip();
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.getTextColor(context, secondary: true),
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 1.5.h,
              ),
            ),
            child: Text(
              'Skip for Now',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.getTextColor(context, secondary: true),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),

          // Safe area bottom padding
          SizedBox(height: MediaQuery.of(context).padding.bottom > 0 ? 1.h : 0),
        ],
      ),
    );
  }
}
