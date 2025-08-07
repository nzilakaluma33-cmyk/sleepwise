import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class AIInsightsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> insights;

  const AIInsightsWidget({
    super.key,
    required this.insights,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text('AI Insights',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
        SizedBox(width: 2.w),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Text('NEW',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600))),
      ]),
      SizedBox(height: 2.h),
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: insights.length,
          separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
          itemBuilder: (context, index) {
            final insight = insights[index];
            return _buildInsightCard(context, insight);
          }),
    ]);
  }

  Widget _buildInsightCard(BuildContext context, Map<String, dynamic> insight) {
    Color cardColor;
    Color iconColor;

    switch (insight['type']) {
      case 'improvement':
        cardColor = Theme.of(context).primaryColor;
        iconColor = Theme.of(context).primaryColor;
        break;
      case 'achievement':
        cardColor = Colors.green;
        iconColor = Colors.green;
        break;
      case 'recommendation':
        cardColor = Theme.of(context).colorScheme.secondary;
        iconColor = Theme.of(context).colorScheme.secondary;
        break;
      default:
        cardColor = Theme.of(context).primaryColor;
        iconColor = Theme.of(context).primaryColor;
    }

    return GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          // Navigate to detailed insight
        },
        child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cardColor.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                      color: cardColor.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2)),
                ]),
            child: Row(children: [
              Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                      color: cardColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle),
                  child: Center(
                      child: CustomIconWidget(
                          iconName: insight['icon'],
                          color: iconColor,
                          size: 24))),
              SizedBox(width: 4.w),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Expanded(
                          child: Text(insight['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600))),
                      if (insight['priority'] == 'high')
                        Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(shape: BoxShape.circle)),
                    ]),
                    SizedBox(height: 0.5.h),
                    Text(insight['description'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant)),
                  ])),
              CustomIconWidget(
                  iconName: 'chevron_right',
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20),
            ])));
  }
}
