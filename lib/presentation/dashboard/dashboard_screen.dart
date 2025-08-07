import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_insights_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/sleep_score_widget.dart';
import './widgets/sleep_stats_widget.dart';
import './widgets/sleep_trend_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 0;

  // Mock sleep data
  final Map<String, dynamic> sleepData = {
    'lastNightSleep': {
      'duration': '7h 32m',
      'quality': 85,
      'efficiency': 89,
      'deepSleep': '1h 45m',
      'remSleep': '1h 20m',
      'lightSleep': '4h 27m',
      'bedtime': '10:30 PM',
      'wakeTime': '6:02 AM',
      'score': 85,
    },
    'weeklyAverage': {
      'duration': '7h 15m',
      'quality': 82,
      'consistency': 78,
    },
    'sleepDebt': -2.5, // hours
    'streak': 5, // consecutive good nights
  };

  final List<Map<String, dynamic>> aiInsights = [
    {
      'type': 'improvement',
      'title': 'Bedtime Consistency',
      'description':
          'Try going to bed 15 minutes earlier for better deep sleep',
      'icon': 'schedule',
      'priority': 'high',
    },
    {
      'type': 'achievement',
      'title': 'Great Week!',
      'description': 'You\'ve maintained good sleep quality for 5 days',
      'icon': 'emoji_events',
      'priority': 'medium',
    },
    {
      'type': 'recommendation',
      'title': 'Wind-down Routine',
      'description':
          'Consider starting your relaxation routine 30 minutes earlier',
      'icon': 'self_improvement',
      'priority': 'low',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    HapticFeedback.selectionClick();

    // Navigate to respective screens
    switch (index) {
      case 0:
        // Already on dashboard
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.sleepAnalyticsDashboard);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.relaxationSleepSounds);
        break;
      case 3:
        // Profile screen - to be implemented
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile screen coming soon!'),
            duration: Duration(seconds: 2),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'bedtime',
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                Text(
                  'SleepWise',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to settings
            },
            icon: CustomIconWidget(
              iconName: 'settings',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigate to notifications
            },
            icon: CustomIconWidget(
              iconName: 'notifications',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              // Sleep Score Card
              SleepScoreWidget(
                score: sleepData['lastNightSleep']['score'],
                quality: sleepData['lastNightSleep']['quality'],
                duration: sleepData['lastNightSleep']['duration'],
                efficiency: sleepData['lastNightSleep']['efficiency'],
              ),

              SizedBox(height: 3.h),

              // Sleep Stats Overview
              SleepStatsWidget(
                deepSleep: sleepData['lastNightSleep']['deepSleep'],
                remSleep: sleepData['lastNightSleep']['remSleep'],
                lightSleep: sleepData['lastNightSleep']['lightSleep'],
                bedtime: sleepData['lastNightSleep']['bedtime'],
                wakeTime: sleepData['lastNightSleep']['wakeTime'],
              ),

              SizedBox(height: 3.h),

              // Quick Actions
              QuickActionsWidget(),

              SizedBox(height: 3.h),

              // Sleep Trend Chart
              SleepTrendWidget(
                weeklyAverage: sleepData['weeklyAverage'],
                sleepDebt: sleepData['sleepDebt'],
                streak: sleepData['streak'],
              ),

              SizedBox(height: 3.h),

              // AI Insights
              AIInsightsWidget(insights: aiInsights),

              SizedBox(height: 3.h),

              // Sleep Environment Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'home',
                          color: Theme.of(context).colorScheme.primary,
                          size: 24,
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          'Sleep Environment',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildEnvironmentStat(
                            'Temperature', '68°F', 'thermostat'),
                        _buildEnvironmentStat('Humidity', '45%', 'water_drop'),
                        _buildEnvironmentStat('Noise', '32 dB', 'volume_down'),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h), // Bottom padding for navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
          selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'home',
                size: 24,
                color: _selectedIndex == 0
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'analytics',
                size: 24,
                color: _selectedIndex == 1
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              label: 'Analytics',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'self_improvement',
                size: 24,
                color: _selectedIndex == 2
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              label: 'Relaxation',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'person',
                size: 24,
                color: _selectedIndex == 3
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentStat(String label, String value, String iconName) {
    return Column(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
