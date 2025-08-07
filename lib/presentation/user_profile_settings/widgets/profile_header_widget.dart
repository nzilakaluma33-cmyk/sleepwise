import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onEditProfile;
  final VoidCallback onUpgradeToPremium;

  const ProfileHeaderWidget({
    super.key,
    required this.userData,
    required this.onEditProfile,
    required this.onUpgradeToPremium,
  });

  @override
  Widget build(BuildContext context) {
    final isPremium = userData['membershipStatus'] == 'Premium';

    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8)),
            ]),
        child: Column(children: [
          // Profile Image and Info
          Row(children: [
            // Profile Image
            GestureDetector(
                onTap: () {
                  onEditProfile();
                  HapticFeedback.lightImpact();
                },
                child: Stack(children: [
                  Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 2)),
                      child: ClipOval(
                          child: CustomImageWidget(
                              imageUrl: userData['profileImage'] ?? '',
                              width: 20.w, 
                              height: 20.w, 
                              fit: BoxFit.cover))),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          padding: EdgeInsets.all(1.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2)),
                              ]),
                          child: CustomIconWidget(
                              iconName: 'edit',
                              color: Theme.of(context).colorScheme.primary,
                              size: 12))),
                ])),

            SizedBox(width: 4.w),

            // User Info
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(userData['name'] ?? 'User',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w700)),
                  SizedBox(height: 0.5.h),
                  Row(children: [
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: isPremium
                                ? const Color(0xFFFFD700).withValues(alpha: 0.2)
                                : Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          if (isPremium)
                            const CustomIconWidget(
                                iconName: 'star',
                                color: Color(0xFFFFD700),
                                size: 12),
                          if (isPremium) SizedBox(width: 1.w),
                          Text(userData['membershipStatus'] ?? 'Free',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: isPremium
                                          ? const Color(0xFFFFD700)
                                          : Colors.white.withValues(alpha: 0.9),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10)),
                        ])),
                    if (!isPremium) ...[
                      SizedBox(width: 2.w),
                      GestureDetector(
                          onTap: onUpgradeToPremium,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFFFD700),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text('Upgrade',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10)))),
                    ],
                  ]),
                  SizedBox(height: 0.5.h),
                  Text('Member since ${userData['joinDate'] ?? 'Unknown'}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 11)),
                ])),
          ]),

          SizedBox(height: 4.h),

          // Sleep Statistics
          Row(children: [
            Expanded(
                child: _buildStatItem(
                    context,
                    'Sleep Streak',
                    '${userData['sleepStreak'] ?? 0} days',
                    'local_fire_department',
                    const Color(0xFFFF6B6B))),
            Container(
                width: 1,
                height: 6.h,
                color: Colors.white.withValues(alpha: 0.2)),
            Expanded(
                child: _buildStatItem(
                    context,
                    'Total Nights',
                    '${userData['totalNights'] ?? 0}',
                    'nights_stay',
                    const Color(0xFF4ECDC4))),
            Container(
                width: 1,
                height: 6.h,
                color: Colors.white.withValues(alpha: 0.2)),
            Expanded(
                child: _buildStatItem(
                    context,
                    'Achievements',
                    '${userData['achievements'] ?? 0}',
                    'emoji_events',
                    const Color(0xFFFFD700))),
          ]),
        ]));
  }

  Widget _buildStatItem(BuildContext context, String label, String value,
      String iconName, Color iconColor) {
    return Column(children: [
      Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.2), shape: BoxShape.circle),
          child:
              CustomIconWidget(iconName: iconName, color: iconColor, size: 20)),
      SizedBox(height: 1.h),
      Text(value,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
      Text(label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.8), fontSize: 10),
          textAlign: TextAlign.center),
    ]);
  }
}