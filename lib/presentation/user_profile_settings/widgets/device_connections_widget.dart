import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class DeviceConnectionsWidget extends StatelessWidget {
  DeviceConnectionsWidget({super.key});

  final List<Map<String, dynamic>> connectedDevices = [
    {
      'name': 'Apple Watch Series 9',
      'type': 'Wearable',
      'status': 'Connected',
      'battery': 85,
      'icon': 'watch',
      'lastSync': '2 minutes ago',
    },
    {
      'name': 'Sleep Number Bed',
      'type': 'Smart Mattress',
      'status': 'Connected',
      'battery': null,
      'icon': 'bed',
      'lastSync': '5 minutes ago',
    },
    {
      'name': 'Philips Hue Bridge',
      'type': 'Environmental',
      'status': 'Disconnected',
      'battery': null,
      'icon': 'lightbulb',
      'lastSync': '2 hours ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'devices',
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Smart Device Connections',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      Text(
                        '${connectedDevices.where((d) => d['status'] == 'Connected').length} of ${connectedDevices.length} devices connected',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Add new device
                    HapticFeedback.lightImpact();
                  },
                  icon: CustomIconWidget(
                    iconName: 'add',
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Device List
          ...connectedDevices.asMap().entries.map((entry) {
            final index = entry.key;
            final device = entry.value;
            final isLast = index == connectedDevices.length - 1;

            return Column(
              children: [
                if (index == 0)
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.1),
                  ),
                _buildDeviceItem(context, device),
                if (!isLast)
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.1),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDeviceItem(BuildContext context, Map<String, dynamic> device) {
    final isConnected = device['status'] == 'Connected';
    final statusColor = isConnected
        ? const Color(0xFF38A169)
        : Theme.of(context).colorScheme.error;

    return InkWell(
      onTap: () {
        // Open device settings
        HapticFeedback.lightImpact();
      },
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            // Device Icon
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: isConnected
                    ? statusColor.withValues(alpha: 0.1)
                    : Theme.of(context)
                        .colorScheme
                        .errorContainer
                        .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomIconWidget(
                iconName: device['icon'] ?? 'device_unknown',
                color: statusColor,
                size: 24,
              ),
            ),

            SizedBox(width: 4.w),

            // Device Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device['name'] ?? 'Unknown Device',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Container(
                        width: 2.w,
                        height: 2.w,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        device['status'] ?? 'Unknown',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      if (device['battery'] != null) ...[
                        SizedBox(width: 3.w),
                        CustomIconWidget(
                          iconName: 'battery_std',
                          color: _getBatteryColor(device['battery']),
                          size: 12,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '${device['battery']}%',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 11,
                                  ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Last sync: ${device['lastSync'] ?? 'Never'}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),

            // Action Button/Indicator
            if (isConnected)
              CustomIconWidget(
                iconName: 'check_circle',
                color: statusColor,
                size: 20,
              )
            else
              IconButton(
                onPressed: () {
                  // Reconnect device
                  HapticFeedback.lightImpact();
                },
                icon: CustomIconWidget(
                  iconName: 'refresh',
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getBatteryColor(int? battery) {
    if (battery == null) return Colors.grey;
    if (battery > 50) return const Color(0xFF38A169);
    if (battery > 20) return const Color(0xFFFFB800);
    return const Color(0xFFE53E3E);
  }
}
