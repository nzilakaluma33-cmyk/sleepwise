import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WelcomeContentWidget extends StatelessWidget {
  const WelcomeContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Main headline
        Text(
          'Welcome to SleepWise',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.getTextColor(context),
              ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 1.h),

        // Subheadline
        Text(
          'AI-Powered Sleep Optimization',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 3.h),

        // Description
        Text(
          'Discover the power of personalized sleep tracking. Our AI analyzes your unique sleep patterns, provides intelligent insights, and delivers customized recommendations to transform your sleep quality.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.getTextColor(context, secondary: true),
                height: 1.6,
              ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 4.h),

        // Feature highlights
        _buildFeatureList(context),

        SizedBox(height: 4.h),

        // Privacy reassurance
        Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'security',
                size: 5.w > 20 ? 20 : 5.w,
                color: AppTheme.getSuccessColor(context),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Your data is secure and GDPR compliant. We prioritize your privacy above all.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.getTextColor(context, secondary: true),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureList(BuildContext context) {
    final features = [
      {
        'icon': 'analytics',
        'title': 'Smart Analysis',
        'description': 'AI-powered sleep pattern recognition',
      },
      {
        'icon': 'insights',
        'title': 'Personalized Insights',
        'description': 'Tailored recommendations for better sleep',
      },
      {
        'icon': 'trending_up',
        'title': 'Progress Tracking',
        'description': 'Monitor your sleep improvement journey',
      },
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                constraints: BoxConstraints(
                  maxWidth: 48,
                  maxHeight: 48,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: feature['icon'] as String,
                    size: 6.w > 24 ? 24 : 6.w,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'] as String,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.getTextColor(context),
                          ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      feature['description'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                AppTheme.getTextColor(context, secondary: true),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
