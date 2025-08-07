import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FeaturedContentWidget extends StatelessWidget {
  final List<Map<String, dynamic>> featuredContent;
  final Function(Map<String, dynamic>) onContentTap;

  const FeaturedContentWidget({
    super.key,
    required this.featuredContent,
    required this.onContentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Featured Today',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            GestureDetector(
                onTap: () {
                  // Navigate to all featured content
                },
                child: Text('View All',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500))),
          ])),
      SizedBox(height: 2.h),
      SizedBox(
          height: 30.h,
          child: PageView.builder(
              padEnds: false,
              controller: PageController(viewportFraction: 0.85),
              itemCount: featuredContent.length,
              itemBuilder: (context, index) {
                final content = featuredContent[index];
                return GestureDetector(
                    onTap: () {
                      onContentTap(content);
                      HapticFeedback.lightImpact();
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? 4.w : 2.w, right: 2.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8)),
                            ]),
                        child: Stack(children: [
                          // Background Image
                          ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CustomImageWidget(
                                  imageUrl: content['imageUrl'] ?? '',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover)),

                          // Gradient Overlay
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.8),
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.2),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter))),

                          // Content
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                  padding: EdgeInsets.all(5.w),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Category Tag
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 3.w,
                                                vertical: 0.5.h),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text(
                                                content['category'] ??
                                                    'Featured',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10))),

                                        SizedBox(height: 2.h),

                                        // Title
                                        Text(content['title'] ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),

                                        SizedBox(height: 1.h),

                                        // Description
                                        Text(content['description'] ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    height: 1.4),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),

                                        SizedBox(height: 2.h),

                                        // Play Button & Info
                                        Row(children: [
                                          Container(
                                              padding: EdgeInsets.all(2.w),
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                  shape: BoxShape.circle),
                                              child: const CustomIconWidget(
                                                  iconName: 'play_arrow',
                                                  color: Colors.black,
                                                  size: 20)),
                                          SizedBox(width: 3.w),
                                          Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                Row(children: [
                                                  const CustomIconWidget(
                                                      iconName: 'schedule',
                                                      color: Colors.white,
                                                      size: 14),
                                                  SizedBox(width: 1.w),
                                                  Text(
                                                      content['duration'] ??
                                                          '45:00',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.9),
                                                              fontSize: 12)),
                                                ]),
                                                Row(children: [
                                                  const CustomIconWidget(
                                                      iconName: 'star',
                                                      color: Color(0xFFFFD700),
                                                      size: 14),
                                                  SizedBox(width: 1.w),
                                                  Text(
                                                      content['rating']
                                                              ?.toString() ??
                                                          '4.8',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.9),
                                                              fontSize: 12)),
                                                  SizedBox(width: 2.w),
                                                  Text(
                                                      '(${content['listens'] ?? '2.1k'})',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.7),
                                                              fontSize: 11)),
                                                ]),
                                              ])),
                                        ]),
                                      ]))),

                          // Premium Badge
                          if (content['isPremium'] == true)
                            Positioned(
                                top: 4.w,
                                right: 4.w,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 0.5.h),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Color(0xFFFFD700),
                                          Color(0xFFFFB800)
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const CustomIconWidget(
                                              iconName: 'star',
                                              color: Colors.white,
                                              size: 12),
                                          SizedBox(width: 1.w),
                                          Text('PRO',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10)),
                                        ]))),
                        ])));
              })),
    ]);
  }
}