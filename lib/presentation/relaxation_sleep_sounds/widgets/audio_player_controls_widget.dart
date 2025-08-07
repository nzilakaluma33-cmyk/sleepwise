import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class AudioPlayerControlsWidget extends StatefulWidget {
  final bool isPlaying;
  final Duration currentPosition;
  final Duration totalDuration;
  final VoidCallback onPlayPause;
  final Function(Duration) onSeek;
  final Function(int) onTimerSet;

  const AudioPlayerControlsWidget({
    super.key,
    required this.isPlaying,
    required this.currentPosition,
    required this.totalDuration,
    required this.onPlayPause,
    required this.onSeek,
    required this.onTimerSet,
  });

  @override
  State<AudioPlayerControlsWidget> createState() =>
      _AudioPlayerControlsWidgetState();
}

class _AudioPlayerControlsWidgetState extends State<AudioPlayerControlsWidget> {
  bool _showTimerOptions = false;
  int _selectedTimer = 0; // 0 = off
  final List<int> _timerOptions = [0, 15, 30, 60, 120, 480]; // minutes

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withValues(alpha: 0.8),
            Colors.black.withValues(alpha: 0.6),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress Bar
          Row(
            children: [
              Text(
                _formatDuration(widget.currentPosition),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
              ),
              Expanded(
                child: Slider(
                  value: widget.totalDuration.inSeconds > 0
                      ? widget.currentPosition.inSeconds.toDouble()
                      : 0.0,
                  max: widget.totalDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    widget.onSeek(Duration(seconds: value.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.white.withValues(alpha: 0.3),
                  thumbColor: Colors.white,
                ),
              ),
              Text(
                _formatDuration(widget.totalDuration),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Main Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Skip Backward
              _buildControlButton(
                'skip_previous',
                () {
                  final newPosition =
                      widget.currentPosition - const Duration(seconds: 30);
                  widget.onSeek(
                      newPosition.isNegative ? Duration.zero : newPosition);
                  HapticFeedback.lightImpact();
                },
              ),

              // Play/Pause
              GestureDetector(
                onTap: () {
                  widget.onPlayPause();
                  HapticFeedback.mediumImpact();
                },
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: widget.isPlaying ? 'pause' : 'play_arrow',
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
              ),

              // Skip Forward
              _buildControlButton(
                'skip_next',
                () {
                  final newPosition =
                      widget.currentPosition + const Duration(seconds: 30);
                  if (newPosition < widget.totalDuration) {
                    widget.onSeek(newPosition);
                  }
                  HapticFeedback.lightImpact();
                },
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Additional Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Volume Control
              _buildSecondaryButton('volume_up', () {
                // Volume control
              }),

              // Sleep Timer
              _buildSecondaryButton(
                'timer',
                () {
                  setState(() {
                    _showTimerOptions = !_showTimerOptions;
                  });
                },
                isActive: _selectedTimer > 0,
              ),

              // Mix Sounds
              _buildSecondaryButton('tune', () {
                // Mix sounds functionality
              }),

              // Favorite
              _buildSecondaryButton('favorite_border', () {
                // Add to favorites
              }),
            ],
          ),

          // Timer Options
          if (_showTimerOptions) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sleep Timer',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 2.h),
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: _timerOptions.map((minutes) {
                      final isSelected = _selectedTimer == minutes;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTimer = minutes;
                          });
                          widget.onTimerSet(minutes);
                          HapticFeedback.selectionClick();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            minutes == 0 ? 'Off' : '${minutes}m',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      isSelected ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildControlButton(String iconName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: iconName,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(
    String iconName,
    VoidCallback onTap, {
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomIconWidget(
          iconName: iconName,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
