import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/ai_insights_section_widget.dart';
import './widgets/metrics_cards_widget.dart';
import './widgets/sleep_pattern_chart_widget.dart';
import './widgets/sleep_score_card_widget.dart';

class SleepAnalyticsDashboard extends StatefulWidget {
  const SleepAnalyticsDashboard({super.key});

  @override
  State<SleepAnalyticsDashboard> createState() =>
      _SleepAnalyticsDashboardState();
}

class _SleepAnalyticsDashboardState extends State<SleepAnalyticsDashboard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  String selectedPeriod = '7 days';
  final List<String> timePeriods = ['7 days', '30 days', '3 months'];

  // Mock analytics data
  final Map<String, dynamic> analyticsData = {
    'sleepScore': 85,
    'quality': 'Good',
    'trend': '↗ +5%',
    'averageDuration': '7h 32m',
    'efficiency': 89,
    'sleepBreakdown': {
      'deep': '1h 45m',
      'rem': '1h 20m',
      'light': '4h 27m',
    },
    'weeklyData': [
      {'day': 'Sun', 'duration': 7.5, 'quality': 80},
      {'day': 'Mon', 'duration': 8.2, 'quality': 85},
      {'day': 'Tue', 'duration': 7.8, 'quality': 82},
      {'day': 'Wed', 'duration': 8.5, 'quality': 90},
      {'day': 'Thu', 'duration': 7.2, 'quality': 75},
      {'day': 'Fri', 'duration': 8.0, 'quality': 88},
      {'day': 'Sat', 'duration': 7.5, 'quality': 83},
    ],
  };

  final List<Map<String, dynamic>> aiInsights = [
    {
      'type': 'improvement',
      'title': 'Bedtime Consistency',
      'description':
          'Your bedtime varies by 45 minutes. Try going to bed at the same time each night for better sleep quality.',
      'icon': 'schedule',
      'priority': 'high',
    },
    {
      'type': 'achievement',
      'title': 'Deep Sleep Achievement',
      'description':
          'Excellent! You achieved 25% deep sleep last night, which is above the recommended 20%.',
      'icon': 'emoji_events',
      'priority': 'medium',
    },
    {
      'type': 'recommendation',
      'title': 'Sleep Environment',
      'description':
          'Consider lowering your bedroom temperature by 2-3°F for optimal sleep conditions.',
      'icon': 'thermostat',
      'priority': 'low',
    },
    {
      'type': 'warning',
      'title': 'Sleep Debt Alert',
      'description':
          'You have accumulated 2.5 hours of sleep debt this week. Try to get extra rest this weekend.',
      'icon': 'warning',
      'priority': 'high',
    },
  ];

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
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onPeriodChanged(String period) {
    setState(() {
      selectedPeriod = period;
    });
    HapticFeedback.selectionClick();
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
        ),
        title: Text(
          'Sleep Analytics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Export functionality
            },
            icon: CustomIconWidget(
              iconName: 'file_download',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          SizedBox(width: 2.w),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: timePeriods.map((period) {
                        final isSelected = period == selectedPeriod;
                        return GestureDetector(
                          onTap: () => _onPeriodChanged(period),
                          child: Container(
                            margin: EdgeInsets.only(right: 3.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .outline
                                        .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              period,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                // Sleep Score Card
                SleepScoreCardWidget(
                  score: analyticsData['sleepScore'],
                  quality: analyticsData['quality'],
                  trend: analyticsData['trend'],
                ),

                SizedBox(height: 3.h),

                // Metrics Cards
                MetricsCardsWidget(
                  averageDuration: analyticsData['averageDuration'],
                  efficiency: analyticsData['efficiency'],
                  sleepBreakdown: analyticsData['sleepBreakdown'],
                ),

                SizedBox(height: 3.h),

                // Sleep Pattern Chart
                SleepPatternChartWidget(
                  weeklyData: List<Map<String, dynamic>>.from(
                    analyticsData['weeklyData'],
                  ),
                ),

                SizedBox(height: 3.h),

                // AI Insights Section
                AIInsightsSectionWidget(insights: aiInsights),

                SizedBox(height: 3.h),

                // Progress Tracking Card
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
                            iconName: 'trending_up',
                            color: Theme.of(context).colorScheme.primary,
                            size: 24,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'Progress Tracking',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildProgressItem(
                              context,
                              'Sleep Goal',
                              '85%',
                              0.85,
                              const Color(0xFF38A169),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: _buildProgressItem(
                              context,
                              'Consistency',
                              '72%',
                              0.72,
                              const Color(0xFF6B73C4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressItem(
    BuildContext context,
    String label,
    String percentage,
    double progress,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            Text(
              percentage,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: color.withValues(alpha: 0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
