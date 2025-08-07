import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SoundCategoryWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> sounds;
  final Function(Map<String, dynamic>) onSoundTap;
  final String? currentPlayingId;

  const SoundCategoryWidget({
    super.key,
    required this.title,
    required this.sounds,
    required this.onSoundTap,
    this.currentPlayingId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white, fontWeight: FontWeight.w600))),
      SizedBox(height: 2.h),
      SizedBox(
          height: 25.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: sounds.length,
              itemBuilder: (context, index) {
                final sound = sounds[index];
                final isPlaying = currentPlayingId == sound['id'];

                return GestureDetector(
                    onTap: () {
                      onSoundTap(sound);
                      HapticFeedback.lightImpact();
                    },
                    child: Container(
                        width: 40.w,
                        margin: EdgeInsets.only(right: 3.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.3),
                                  Colors.black.withValues(alpha: 0.1),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter)),
                        child: Stack(children: [
                          // Background Image
                          ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CustomImageWidget(
                                  imageUrl: sound['imageUrl'],
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover)),

                          // Gradient Overlay
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withValues(alpha: 0.7),
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.3),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter))),

                          // Content
                          Padding(
                              padding: EdgeInsets.all(4.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top Row - Duration & Premium
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.w,
                                                  vertical: 0.5.h),
                                              decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Text(
                                                  sound['duration'] ?? '10:00',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontSize: 10))),
                                          if (sound['isPremium'] == true)
                                            Container(
                                                padding: EdgeInsets.all(1.w),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFFFD700)
                                                            .withValues(
                                                                alpha: 0.2),
                                                    shape: BoxShape.circle),
                                                child: const CustomIconWidget(
                                                    iconName: 'star',
                                                    color: Color(0xFFFFD700),
                                                    size: 12)),
                                        ]),

                                    const Spacer(),

                                    // Bottom Content
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(sound['title'] ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                          SizedBox(height: 0.5.h),
                                          Row(children: [
                                            CustomIconWidget(
                                                iconName: isPlaying
                                                    ? 'pause_circle'
                                                    : 'play_circle',
                                                color: Colors.white,
                                                size: 20),
                                            SizedBox(width: 2.w),
                                            Expanded(
                                                child: Text(
                                                    isPlaying
                                                        ? 'Playing...'
                                                        : 'Tap to play',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                            color: Colors.white
                                                                .withValues(
                                                                    alpha: 0.8),
                                                            fontSize: 11))),
                                          ]),
                                          SizedBox(height: 1.h),
                                          // Rating & Downloads
                                          Row(children: [
                                            const CustomIconWidget(
                                                iconName: 'star',
                                                color: Color(0xFFFFD700),
                                                size: 12),
                                            SizedBox(width: 1.w),
                                            Text(
                                                sound['rating']?.toString() ??
                                                    '4.5',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.white
                                                            .withValues(
                                                                alpha: 0.8),
                                                        fontSize: 10)),
                                            SizedBox(width: 3.w),
                                            if (sound['isDownloaded'] == true)
                                              const CustomIconWidget(
                                                  iconName: 'download_done',
                                                  color: Color(0xFF4ECDC4),
                                                  size: 12),
                                          ]),
                                        ]),
                                  ])),

                          // Playing Indicator
                          if (isPlaying)
                            Positioned(
                                top: 2.w,
                                right: 2.w,
                                child: Container(
                                    padding: EdgeInsets.all(1.w),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        shape: BoxShape.circle),
                                    child: const CustomIconWidget(
                                        iconName: 'graphic_eq',
                                        color: Colors.white,
                                        size: 12))),
                        ])));
              })),
    ]);
  }
}