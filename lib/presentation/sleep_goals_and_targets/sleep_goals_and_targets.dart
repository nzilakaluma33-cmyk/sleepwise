import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/goal_card_widget.dart';
import './widgets/motivation_style_widget.dart';
import './widgets/progress_header_widget.dart';
import './widgets/timeline_selector_widget.dart';

class SleepGoalsAndTargets extends StatefulWidget {
  const SleepGoalsAndTargets({super.key});

  @override
  State<SleepGoalsAndTargets> createState() => _SleepGoalsAndTargetsState();
}

class _SleepGoalsAndTargetsState extends State<SleepGoalsAndTargets> {
  final List<String> selectedGoals = [];
  String selectedTimeline = '1 month';
  String selectedMotivationStyle = 'Gentle encouragement';
  final List<String> selectedChallenges = [];

  final List<Map<String, dynamic>> sleepGoals = [
    {
      "id": "better_quality",
      "title": "Better Sleep Quality",
      "description": "Improve overall sleep satisfaction and restfulness",
      "icon": "bedtime",
      "targetMetric": "Sleep efficiency above 85%",
      "difficulty": "Medium",
      "isSelected": false,
    },
    {
      "id": "fall_asleep_faster",
      "title": "Fall Asleep Faster",
      "description": "Reduce time to fall asleep and eliminate tossing",
      "icon": "timer",
      "targetMetric": "Sleep latency under 15 minutes",
      "difficulty": "Easy",
      "isSelected": false,
    },
    {
      "id": "sleep_through_night",
      "title": "Sleep Through Night",
      "description": "Minimize wake episodes and stay asleep longer",
      "icon": "nights_stay",
      "targetMetric": "Wake episodes less than 2 per night",
      "difficulty": "Hard",
      "isSelected": false,
    },
    {
      "id": "wake_refreshed",
      "title": "Wake Up Refreshed",
      "description": "Feel energized and alert upon waking",
      "icon": "wb_sunny",
      "targetMetric": "Morning energy level above 7/10",
      "difficulty": "Medium",
      "isSelected": false,
    },
    {
      "id": "consistent_schedule",
      "title": "Consistent Schedule",
      "description": "Maintain regular bedtime and wake time",
      "icon": "schedule",
      "targetMetric": "Schedule variance under 30 minutes",
      "difficulty": "Easy",
      "isSelected": false,
    },
    {
      "id": "reduce_sleep_debt",
      "title": "Reduce Sleep Debt",
      "description": "Get adequate sleep hours for recovery",
      "icon": "battery_charging_full",
      "targetMetric": "7-9 hours nightly sleep duration",
      "difficulty": "Medium",
      "isSelected": false,
    },
  ];

  final List<Map<String, dynamic>> timelineOptions = [
    {
      "value": "2 weeks",
      "difficulty": "Quick Start",
      "color": AppTheme.successLight
    },
    {
      "value": "1 month",
      "difficulty": "Balanced",
      "color": AppTheme.primaryLight
    },
    {
      "value": "3 months",
      "difficulty": "Sustainable",
      "color": AppTheme.accentLight
    },
    {
      "value": "6 months",
      "difficulty": "Long-term",
      "color": AppTheme.warningLight
    },
  ];

  final List<Map<String, dynamic>> motivationStyles = [
    {
      "title": "Gentle encouragement",
      "description": "Supportive and understanding approach",
      "icon": "favorite",
    },
    {
      "title": "Data-driven insights",
      "description": "Focus on metrics and analytical feedback",
      "icon": "analytics",
    },
    {
      "title": "Achievement-focused",
      "description": "Goal-oriented with milestone celebrations",
      "icon": "emoji_events",
    },
    {
      "title": "Habit-building approach",
      "description": "Emphasis on routine and consistency",
      "icon": "repeat",
    },
  ];

  final List<Map<String, dynamic>> sleepChallenges = [
    {"title": "Stress and anxiety", "icon": "psychology", "priority": 0},
    {"title": "Caffeine consumption", "icon": "local_cafe", "priority": 0},
    {"title": "Screen time before bed", "icon": "phone_android", "priority": 0},
    {"title": "Irregular schedule", "icon": "schedule", "priority": 0},
    {"title": "Noisy environment", "icon": "volume_up", "priority": 0},
    {"title": "Uncomfortable temperature", "icon": "thermostat", "priority": 0},
  ];

  void _toggleGoalSelection(String goalId) {
    setState(() {
      if (selectedGoals.contains(goalId)) {
        selectedGoals.remove(goalId);
      } else {
        selectedGoals.add(goalId);
        _suggestComplementaryGoals(goalId);
      }
    });
  }

  void _suggestComplementaryGoals(String selectedGoalId) {
    final Map<String, List<String>> complementaryGoals = {
      "better_quality": ["sleep_through_night", "wake_refreshed"],
      "fall_asleep_faster": ["consistent_schedule", "reduce_sleep_debt"],
      "sleep_through_night": ["better_quality", "wake_refreshed"],
      "wake_refreshed": ["better_quality", "reduce_sleep_debt"],
      "consistent_schedule": ["fall_asleep_faster", "reduce_sleep_debt"],
      "reduce_sleep_debt": ["consistent_schedule", "wake_refreshed"],
    };

    final List<String>? suggestions = complementaryGoals[selectedGoalId];
    if (suggestions != null) {
      for (String suggestion in suggestions) {
        if (!selectedGoals.contains(suggestion) && selectedGoals.length < 3) {
          // Show suggestion dialog or auto-suggest
          break;
        }
      }
    }
  }

  void _toggleChallengeSelection(String challenge) {
    setState(() {
      if (selectedChallenges.contains(challenge)) {
        selectedChallenges.remove(challenge);
      } else {
        selectedChallenges.add(challenge);
      }
    });
  }

  void _navigateToNext() {
    if (selectedGoals.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one sleep goal to continue'),
        ),
      );
      return;
    }

    // Save goals and navigate to dashboard
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.dashboard,
      (route) => false,
    );
  }

  void _navigateBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: _navigateBack,
          icon: CustomIconWidget(
            iconName: 'arrow_back_ios',
            color: AppTheme.lightTheme.primaryColor,
            size: 24,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.dashboard,
              (route) => false,
            ),
            child: Text(
              'Skip',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            ProgressHeaderWidget(
              currentStep: 7,
              totalSteps: 12,
              title: "What's Your Sleep Goal?",
              subtitle: "Define your personalized sleep improvement objectives",
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 3.h),

                    // Motivational Image
                    Container(
                      width: double.infinity,
                      height: 20.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.lightTheme.primaryColor
                                .withValues(alpha: 0.1),
                            AppTheme.accentLight.withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: CustomImageWidget(
                          imageUrl:
                              "https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
                          width: 80.w,
                          height: 18.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Sleep Goals Section
                    Text(
                      'Select Your Sleep Goals',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'Choose one or more goals to focus on. You can always adjust these later.',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Goals Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.w,
                        mainAxisSpacing: 2.h,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: sleepGoals.length,
                      itemBuilder: (context, index) {
                        final goal = sleepGoals[index];
                        final isSelected = selectedGoals.contains(goal["id"]);

                        return GoalCardWidget(
                          title: goal["title"] as String,
                          description: goal["description"] as String,
                          icon: goal["icon"] as String,
                          targetMetric: goal["targetMetric"] as String,
                          difficulty: goal["difficulty"] as String,
                          isSelected: isSelected,
                          onTap: () =>
                              _toggleGoalSelection(goal["id"] as String),
                        );
                      },
                    ),

                    SizedBox(height: 4.h),

                    // Timeline Selection
                    Text(
                      'Achievement Timeline',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'How long would you like to work towards these goals?',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 2.h),

                    TimelineSelectorWidget(
                      options: timelineOptions,
                      selectedValue: selectedTimeline,
                      onChanged: (value) {
                        setState(() {
                          selectedTimeline = value;
                        });
                      },
                    ),

                    SizedBox(height: 4.h),

                    // Motivation Style
                    Text(
                      'Coaching Style',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'How would you like our AI to motivate and guide you?',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 2.h),

                    MotivationStyleWidget(
                      styles: motivationStyles,
                      selectedStyle: selectedMotivationStyle,
                      onChanged: (value) {
                        setState(() {
                          selectedMotivationStyle = value;
                        });
                      },
                    ),

                    SizedBox(height: 4.h),

                    // Current Challenges
                    Text(
                      'Current Sleep Challenges',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 1.h),

                    Text(
                      'What barriers are currently affecting your sleep? (Optional)',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),

                    SizedBox(height: 2.h),

                    Wrap(
                      spacing: 2.w,
                      runSpacing: 1.h,
                      children: sleepChallenges.map((challenge) {
                        final isSelected =
                            selectedChallenges.contains(challenge["title"]);

                        return FilterChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomIconWidget(
                                iconName: challenge["icon"] as String,
                                size: 16,
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.lightTheme.colorScheme
                                        .onSurfaceVariant,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                challenge["title"] as String,
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.lightTheme.colorScheme
                                          .onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          selected: isSelected,
                          onSelected: (_) => _toggleChallengeSelection(
                              challenge["title"] as String),
                          backgroundColor:
                              AppTheme.lightTheme.colorScheme.surface,
                          selectedColor: AppTheme.lightTheme.primaryColor,
                          checkmarkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? AppTheme.lightTheme.primaryColor
                                  : AppTheme.lightTheme.colorScheme.outline,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 4.h),

                    // Start with Basics Option
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.accentLight.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.accentLight.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'lightbulb',
                                color: AppTheme.accentLight,
                                size: 24,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                'New to sleep tracking?',
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.accentLight,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Start with our beginner-friendly template focusing on consistent sleep schedule and basic sleep hygiene.',
                            style: AppTheme.lightTheme.textTheme.bodyMedium,
                          ),
                          SizedBox(height: 2.h),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedGoals.clear();
                                selectedGoals.addAll(
                                    ['consistent_schedule', 'better_quality']);
                                selectedTimeline = '1 month';
                                selectedMotivationStyle =
                                    'Gentle encouragement';
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppTheme.accentLight,
                              side: BorderSide(color: AppTheme.accentLight),
                            ),
                            child: const Text('Start with basics'),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 6.h),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _navigateBack,
                      child: const Text('Back'),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _navigateToNext,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Complete Setup'),
                          SizedBox(width: 2.w),
                          CustomIconWidget(
                            iconName: 'check',
                            color: Colors.white,
                            size: 20,
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
