import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/account_management_widget.dart';
import './widgets/device_connections_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/settings_section_widget.dart';

class UserProfileSettings extends StatefulWidget {
  const UserProfileSettings({super.key});

  @override
  State<UserProfileSettings> createState() => _UserProfileSettingsState();
}

class _UserProfileSettingsState extends State<UserProfileSettings>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Mock user data
  final Map<String, dynamic> userData = {
    'name': 'Sarah Johnson',
    'email': 'sarah.johnson@email.com',
    'membershipStatus': 'Premium',
    'joinDate': 'March 2024',
    'profileImage':
        'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?w=400',
    'sleepStreak': 12,
    'totalNights': 87,
    'achievements': 5,
  };

  // Settings state
  Map<String, bool> settings = {
    'automaticDetection': true,
    'bedtimeReminders': true,
    'wakeUpAlarms': false,
    'weeklyReports': true,
    'achievementAlerts': true,
    'healthKitSync': true,
    'healthConnectSync': false,
    'dataSharing': false,
    'analyticsSharing': true,
  };

  String selectedTheme = 'System';
  String selectedUnits = 'Imperial';
  String selectedLanguage = 'English';

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

  void _onSettingChanged(String key, bool value) {
    setState(() {
      settings[key] = value;
    });
    HapticFeedback.selectionClick();
  }

  void _onDropdownChanged(String type, String value) {
    setState(() {
      switch (type) {
        case 'theme':
          selectedTheme = value;
          break;
        case 'units':
          selectedUnits = value;
          break;
        case 'language':
          selectedLanguage = value;
          break;
      }
    });
    HapticFeedback.selectionClick();
  }

  void _onEditProfile() {
    // Navigate to edit profile screen
    HapticFeedback.lightImpact();
  }

  void _onUpgradeToPremium() {
    // Navigate to subscription screen
    HapticFeedback.lightImpact();
  }

  void _onExportData() {
    // Export user data
    HapticFeedback.lightImpact();
  }

  void _onDeleteData() {
    // Show delete confirmation dialog
    _showDeleteConfirmationDialog();
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete All Data',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          content: Text(
            'This action cannot be undone. All your sleep data, settings, and account information will be permanently deleted.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Perform data deletion
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
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
          'Profile & Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          IconButton(
            onPressed: _onEditProfile,
            icon: CustomIconWidget(
              iconName: 'edit',
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
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              // Profile Header
              ProfileHeaderWidget(
                userData: userData,
                onEditProfile: _onEditProfile,
                onUpgradeToPremium: _onUpgradeToPremium,
              ),

              SizedBox(height: 4.h),

              // Sleep Tracking Settings
              SettingsSectionWidget(
                title: 'Sleep Tracking',
                icon: 'bedtime',
                children: [
                  _buildSwitchSetting(
                    'Automatic Detection',
                    'Automatically detect sleep patterns',
                    'automaticDetection',
                  ),
                  _buildSwitchSetting(
                    'Manual Entry Preferred',
                    'Prefer manual sleep entry over automatic',
                    'manualEntryPreferred',
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              // Notifications Settings
              SettingsSectionWidget(
                title: 'Notifications',
                icon: 'notifications',
                children: [
                  _buildSwitchSetting(
                    'Bedtime Reminders',
                    'Get notified when it\'s time for bed',
                    'bedtimeReminders',
                  ),
                  _buildSwitchSetting(
                    'Wake-up Alarms',
                    'Smart alarm to wake you gently',
                    'wakeUpAlarms',
                  ),
                  _buildSwitchSetting(
                    'Weekly Reports',
                    'Receive weekly sleep analysis reports',
                    'weeklyReports',
                  ),
                  _buildSwitchSetting(
                    'Achievement Alerts',
                    'Notifications for sleep milestones',
                    'achievementAlerts',
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              // Health App Integration
              SettingsSectionWidget(
                title: 'Health Integration',
                icon: 'health_and_safety',
                children: [
                  _buildSwitchSetting(
                    'iOS HealthKit Sync',
                    'Sync data with Apple Health',
                    'healthKitSync',
                  ),
                  _buildSwitchSetting(
                    'Android Health Connect',
                    'Sync with Google Health platform',
                    'healthConnectSync',
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              // Device Connections
              DeviceConnectionsWidget(),

              SizedBox(height: 3.h),

              // App Preferences
              SettingsSectionWidget(
                title: 'App Preferences',
                icon: 'settings',
                children: [
                  _buildDropdownSetting(
                    'Theme',
                    selectedTheme,
                    ['Light', 'Dark', 'System'],
                    'theme',
                  ),
                  _buildDropdownSetting(
                    'Units',
                    selectedUnits,
                    ['Metric', 'Imperial'],
                    'units',
                  ),
                  _buildDropdownSetting(
                    'Language',
                    selectedLanguage,
                    ['English', 'Spanish', 'French', 'German'],
                    'language',
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              // Privacy & Data
              SettingsSectionWidget(
                title: 'Privacy & Data',
                icon: 'privacy_tip',
                children: [
                  _buildSwitchSetting(
                    'Data Sharing',
                    'Share anonymized data for research',
                    'dataSharing',
                  ),
                  _buildSwitchSetting(
                    'Analytics Sharing',
                    'Help improve the app with usage data',
                    'analyticsSharing',
                  ),
                  _buildActionSetting(
                    'Export Data',
                    'Download your sleep data',
                    'file_download',
                    _onExportData,
                  ),
                  _buildActionSetting(
                    'Delete All Data',
                    'Permanently remove your account and data',
                    'delete_forever',
                    _onDeleteData,
                    isDestructive: true,
                  ),
                ],
              ),

              SizedBox(height: 3.h),

              // Account Management
              AccountManagementWidget(userData: userData),

              SizedBox(height: 10.h), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchSetting(String title, String subtitle, String key) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: settings[key] ?? false,
            onChanged: (value) => _onSettingChanged(key, value),
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSetting(
    String title,
    String currentValue,
    List<String> options,
    String type,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          DropdownButton<String>(
            value: currentValue,
            onChanged: (value) {
              if (value != null) _onDropdownChanged(type, value);
            },
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            underline: const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSetting(
    String title,
    String subtitle,
    String iconName,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: isDestructive
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: isDestructive
                                ? Theme.of(context).colorScheme.error
                                : null,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              CustomIconWidget(
                iconName: 'chevron_right',
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
