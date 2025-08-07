import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/audio_player_controls_widget.dart';
import './widgets/featured_content_widget.dart';
import './widgets/sound_category_widget.dart';

class RelaxationSleepSounds extends StatefulWidget {
  const RelaxationSleepSounds({super.key});

  @override
  State<RelaxationSleepSounds> createState() => _RelaxationSleepSoundsState();
}

class _RelaxationSleepSoundsState extends State<RelaxationSleepSounds>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  bool _isPlaying = false;
  String? _currentPlayingId;
  Duration _currentPosition = Duration.zero;
  final Duration _totalDuration = const Duration(minutes: 45);

  // Mock data
  final List<Map<String, dynamic>> featuredContent = [
    {
      'id': 'featured_1',
      'title': 'Midnight Rain',
      'description':
          'Gentle rainfall sounds for deep relaxation and peaceful sleep',
      'category': 'Nature Sounds',
      'duration': '8:45:00',
      'rating': 4.9,
      'listens': '3.2k',
      'image':
          'https://images.unsplash.com/photo-1519692933481-e162a57d6721?w=400',
      'isPremium': false,
    },
    {
      'id': 'featured_2',
      'title': 'Ocean Waves',
      'description': 'Calming ocean waves to wash away stress and anxiety',
      'category': 'White Noise',
      'duration': '12:30:00',
      'rating': 4.8,
      'listens': '2.8k',
      'image':
          'https://images.pexels.com/photos/1001682/pexels-photo-1001682.jpeg?w=400',
      'isPremium': true,
    },
    {
      'id': 'featured_3',
      'title': 'Forest Meditation',
      'description': 'Guided meditation surrounded by peaceful forest sounds',
      'category': 'Meditation',
      'duration': '25:00',
      'rating': 4.7,
      'listens': '1.9k',
      'image':
          'https://images.pixabay.com/photo/2015/06/19/21/24/forest-815297_1280.jpg?w=400',
      'isPremium': false,
    },
  ];

  final Map<String, List<Map<String, dynamic>>> soundCategories = {
    'Nature Sounds': [
      {
        'id': 'nature_1',
        'title': 'Rain on Leaves',
        'duration': '45:00',
        'rating': 4.8,
        'image':
            'https://images.unsplash.com/photo-1519692933481-e162a57d6721?w=400',
        'isPremium': false,
        'isDownloaded': true,
      },
      {
        'id': 'nature_2',
        'title': 'Forest Birds',
        'duration': '60:00',
        'rating': 4.6,
        'image':
            'https://images.pexels.com/photos/355887/pexels-photo-355887.jpeg?w=400',
        'isPremium': false,
        'isDownloaded': false,
      },
      {
        'id': 'nature_3',
        'title': 'Mountain Stream',
        'duration': '90:00',
        'rating': 4.9,
        'image':
            'https://images.pixabay.com/photo/2017/10/10/07/48/hills-2836301_1280.jpg?w=400',
        'isPremium': true,
        'isDownloaded': false,
      },
    ],
    'White Noise': [
      {
        'id': 'white_1',
        'title': 'Fan Sound',
        'duration': '8:00:00',
        'rating': 4.5,
        'image':
            'https://images.unsplash.com/photo-1558618666-fcfe380c9099?w=400',
        'isPremium': false,
        'isDownloaded': true,
      },
      {
        'id': 'white_2',
        'title': 'Brown Noise',
        'duration': '10:00:00',
        'rating': 4.7,
        'image':
            'https://images.pexels.com/photos/1154510/pexels-photo-1154510.jpeg?w=400',
        'isPremium': true,
        'isDownloaded': false,
      },
    ],
    'Meditation': [
      {
        'id': 'med_1',
        'title': 'Deep Breathing',
        'duration': '15:00',
        'rating': 4.8,
        'image':
            'https://images.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg?w=400',
        'isPremium': false,
        'isDownloaded': false,
      },
      {
        'id': 'med_2',
        'title': 'Body Scan',
        'duration': '25:00',
        'rating': 4.9,
        'image':
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        'isPremium': true,
        'isDownloaded': false,
      },
    ],
    'Sleep Stories': [
      {
        'id': 'story_1',
        'title': 'Enchanted Garden',
        'duration': '35:00',
        'rating': 4.7,
        'image':
            'https://images.pexels.com/photos/1108572/pexels-photo-1108572.jpeg?w=400',
        'isPremium': true,
        'isDownloaded': false,
      },
    ],
  };

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

  void _onContentTap(Map<String, dynamic> content) {
    setState(() {
      if (_currentPlayingId == content['id']) {
        _isPlaying = !_isPlaying;
      } else {
        _currentPlayingId = content['id'];
        _isPlaying = true;
        _currentPosition = Duration.zero;
      }
    });
  }

  void _onPlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _onSeek(Duration position) {
    setState(() {
      _currentPosition = position;
    });
  }

  void _onTimerSet(int minutes) {
    // Timer functionality
    if (minutes > 0) {
      // Set sleep timer
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1419), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const CustomIconWidget(
            iconName: 'arrow_back',
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          'Sleep Sounds',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Search functionality
            },
            icon: const CustomIconWidget(
              iconName: 'search',
              color: Colors.white,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              // Favorites
            },
            icon: const CustomIconWidget(
              iconName: 'favorite_border',
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),

                    // Featured Content
                    FeaturedContentWidget(
                      featuredContent: featuredContent,
                      onContentTap: _onContentTap,
                    ),

                    SizedBox(height: 4.h),

                    // Sound Categories
                    ...soundCategories.entries.map((entry) {
                      return Column(
                        children: [
                          SoundCategoryWidget(
                            title: entry.key,
                            sounds: entry.value,
                            onSoundTap: _onContentTap,
                            currentPlayingId: _currentPlayingId,
                          ),
                          SizedBox(height: 4.h),
                        ],
                      );
                    }),

                    SizedBox(height: 15.h), // Space for player controls
                  ],
                ),
              ),
            ),

            // Audio Player Controls (shown when playing)
            if (_isPlaying && _currentPlayingId != null)
              AudioPlayerControlsWidget(
                isPlaying: _isPlaying,
                currentPosition: _currentPosition,
                totalDuration: _totalDuration,
                onPlayPause: _onPlayPause,
                onSeek: _onSeek,
                onTimerSet: _onTimerSet,
              ),
          ],
        ),
      ),
    );
  }
}
