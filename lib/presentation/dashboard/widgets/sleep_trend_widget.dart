import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SleepTrendWidget extends StatelessWidget {
  final Map<String, dynamic> weeklyAverage;
  final double sleepDebt;
  final int streak;

  const SleepTrendWidget({
    super.key,
    required this.weeklyAverage,
    required this.sleepDebt,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Weekly Overview',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w600)),
      SizedBox(height: 2.h),

      // Weekly Stats Cards
      Row(children: [
        Expanded(
            child: _buildStatCard(
                context,
                'Average Sleep',
                weeklyAverage['duration'],
                'schedule',
                Theme.of(context).colorScheme.primary)),
        SizedBox(width: 3.w),
        Expanded(
            child: _buildStatCard(context, 'Quality Score',
                '${weeklyAverage['quality']}%', 'star', Colors.green)),
      ]),

      SizedBox(height: 2.h),

      Row(children: [
        Expanded(
            child: _buildStatCard(
                context,
                'Sleep Debt',
                sleepDebt >= 0
                    ? '+${sleepDebt.abs().toStringAsFixed(1)}h'
                    : '-${sleepDebt.abs().toStringAsFixed(1)}h',
                sleepDebt >= 0 ? 'battery_charging_full' : 'battery_alert',
                sleepDebt >= 0 ? Colors.blue : Colors.red)),
        SizedBox(width: 3.w),
        Expanded(
            child: _buildStatCard(context, 'Good Night Streak', '$streak days',
                'local_fire_department', Colors.orange)),
      ]),

      SizedBox(height: 3.h),

      // Simple Trend Chart
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
                      .withValues(alpha: 0.2))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CustomIconWidget(
                  iconName: 'trending_up',
                  color: Theme.of(context).colorScheme.primary,
                  size: 24),
              SizedBox(width: 3.w),
              Text('7-Day Sleep Trend',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ]),
            SizedBox(height: 3.h),

            // Mock trend bars
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (index) {
                  final heights = [6.h, 5.h, 7.h, 8.h, 6.5.h, 7.5.h, 8.5.h];
                  final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                  final isToday = index == 6;

                  return Column(children: [
                    Container(
                        width: 8.w,
                        height: heights[index],
                        decoration: BoxDecoration(
                            color: isToday
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4))),
                    SizedBox(height: 1.h),
                    Text(days[index],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isToday
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                            fontWeight:
                                isToday ? FontWeight.w600 : FontWeight.normal)),
                  ]);
                })),
          ])),
    ]);
  }

  Widget _buildStatCard(BuildContext context, String label, String value,
      String iconName, Color color) {
    return Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CustomIconWidget(iconName: iconName, color: color, size: 20),
            SizedBox(width: 2.w),
            Expanded(
                child: Text(label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant))),
          ]),
          SizedBox(height: 1.h),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600, color: color)),
        ]));
  }
}
