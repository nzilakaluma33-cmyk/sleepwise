import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/welcome_actions_widget.dart';
import './widgets/welcome_content_widget.dart';
import './widgets/welcome_illustration_widget.dart';
import './widgets/welcome_progress_widget.dart';

class OnboardingWelcome extends StatefulWidget {
  const OnboardingWelcome({super.key});

  @override
  State<OnboardingWelcome> createState() => _OnboardingWelcomeState();
}

class _OnboardingWelcomeState extends State<OnboardingWelcome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleGetStarted() {
    Navigator.pushNamed(context, AppRoutes.personalInformationSetup);
  }

  void _handleSkip() {
    Navigator.pushNamed(context, AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    // Skip button and progress indicator
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          WelcomeProgressWidget(
                            currentStep: 1,
                            totalSteps: 12,
                          ),
                          TextButton(
                            onPressed: _handleSkip,
                            child: Text(
                              'Skip',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppTheme.getTextColor(context,
                                        secondary: true),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),

                            // Illustration
                            WelcomeIllustrationWidget(),

                            SizedBox(height: 4.h),

                            // Content
                            WelcomeContentWidget(),

                            SizedBox(height: 6.h),
                          ],
                        ),
                      ),
                    ),

                    // Action buttons
                    WelcomeActionsWidget(
                      onGetStarted: _handleGetStarted,
                      onSkip: _handleSkip,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
