import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class WelcomeProgressWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const WelcomeProgressWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step indicator text
        Text(
          'Step $currentStep of $totalSteps',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.getTextColor(context, secondary: true),
                fontWeight: FontWeight.w500,
              ),
        ),

        SizedBox(height: 1.h),

        // Progress bar
        Container(
          width: 50.w,
          height: 0.8.h,
          constraints: BoxConstraints(
            maxWidth: 200,
            minHeight: 6,
            maxHeight: 8,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              // Progress fill
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: (50.w * (currentStep / totalSteps)).clamp(0.0, 50.w),
                height: 0.8.h,
                constraints: BoxConstraints(
                  maxWidth: 200 * (currentStep / totalSteps),
                  minHeight: 6,
                  maxHeight: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      AppTheme.getAccentColor(context),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
