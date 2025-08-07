import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WelcomeIllustrationWidget extends StatelessWidget {
  const WelcomeIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 35.h,
      constraints: BoxConstraints(
        maxWidth: 320,
        maxHeight: 280,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background gradient circle
          Container(
            width: 70.w,
            height: 70.w,
            constraints: BoxConstraints(
              maxWidth: 280,
              maxHeight: 280,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.getAccentColor(context).withValues(alpha: 0.1),
                  Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),

          // Main illustration container
          Container(
            width: 60.w,
            height: 60.w,
            constraints: BoxConstraints(
              maxWidth: 240,
              maxHeight: 240,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Moon icon
                Positioned(
                  top: 15.w,
                  child: CustomIconWidget(
                    iconName: 'nightlight_round',
                    size: 12.w > 48 ? 48 : 12.w,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                // Stars
                Positioned(
                  top: 8.w,
                  right: 12.w,
                  child: CustomIconWidget(
                    iconName: 'star',
                    size: 4.w > 16 ? 16 : 4.w,
                    color: AppTheme.getAccentColor(context),
                  ),
                ),
                Positioned(
                  top: 12.w,
                  left: 10.w,
                  child: CustomIconWidget(
                    iconName: 'star',
                    size: 3.w > 12 ? 12 : 3.w,
                    color:
                        AppTheme.getAccentColor(context).withValues(alpha: 0.7),
                  ),
                ),
                Positioned(
                  bottom: 18.w,
                  right: 8.w,
                  child: CustomIconWidget(
                    iconName: 'star',
                    size: 3.5.w > 14 ? 14 : 3.5.w,
                    color:
                        AppTheme.getAccentColor(context).withValues(alpha: 0.8),
                  ),
                ),

                // Bed/sleep icon
                Positioned(
                  bottom: 12.w,
                  child: CustomIconWidget(
                    iconName: 'bed',
                    size: 10.w > 40 ? 40 : 10.w,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),

                // Sleep waves
                Positioned(
                  bottom: 8.w,
                  left: 8.w,
                  child: Row(
                    children: List.generate(3, (index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 1.w),
                        child: Container(
                          width: 1.5.w > 6 ? 6 : 1.5.w,
                          height: (2 + index * 0.5).w > (8 + index * 2)
                              ? (8 + index * 2).toDouble()
                              : (2 + index * 0.5).w,
                          decoration: BoxDecoration(
                            color: AppTheme.getAccentColor(context)
                                .withValues(alpha: 0.6 - index * 0.1),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
