import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/personal_info_form_widget.dart';
import './widgets/progress_indicator_widget.dart';
import './widgets/why_we_need_info_widget.dart';

class PersonalInformationSetup extends StatefulWidget {
  const PersonalInformationSetup({super.key});

  @override
  State<PersonalInformationSetup> createState() =>
      _PersonalInformationSetupState();
}

class _PersonalInformationSetupState extends State<PersonalInformationSetup> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String _selectedGender = '';
  String _selectedWeightUnit = 'kg';
  String _selectedHeightUnit = 'cm';
  bool _isLoading = false;
  bool _showWhyWeNeedInfo = false;

  final List<String> _genderOptions = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  bool get _isFormValid {
    return _nameController.text.trim().isNotEmpty &&
        _ageController.text.trim().isNotEmpty &&
        _selectedGender.isNotEmpty &&
        _weightController.text.trim().isNotEmpty &&
        _heightController.text.trim().isNotEmpty;
  }

  void _handleContinue() async {
    if (!_isFormValid) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate data processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushNamed(context, AppRoutes.sleepGoalsAndTargets);
    }
  }

  void _handleSkip() {
    Navigator.pushNamed(context, AppRoutes.dashboard);
  }

  void _handleBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: _handleBack,
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
        ),
        title: Text(
          'About You',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          TextButton(
            onPressed: _handleSkip,
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          SizedBox(width: 2.w),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            ProgressIndicatorWidget(
              currentStep: 2,
              totalSteps: 12,
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Text
                      Text(
                        'Tell us about yourself',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'This information helps us personalize your sleep recommendations and provide more accurate insights.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                      SizedBox(height: 3.h),

                      // Personal Information Form
                      PersonalInfoFormWidget(
                        nameController: _nameController,
                        ageController: _ageController,
                        weightController: _weightController,
                        heightController: _heightController,
                        selectedGender: _selectedGender,
                        selectedWeightUnit: _selectedWeightUnit,
                        selectedHeightUnit: _selectedHeightUnit,
                        genderOptions: _genderOptions,
                        onGenderChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        onWeightUnitChanged: (value) {
                          setState(() {
                            _selectedWeightUnit = value;
                          });
                        },
                        onHeightUnitChanged: (value) {
                          setState(() {
                            _selectedHeightUnit = value;
                          });
                        },
                        onFormChanged: () {
                          setState(() {});
                        },
                      ),

                      SizedBox(height: 3.h),

                      // Why We Need This Info
                      WhyWeNeedInfoWidget(
                        isExpanded: _showWhyWeNeedInfo,
                        onToggle: () {
                          setState(() {
                            _showWhyWeNeedInfo = !_showWhyWeNeedInfo;
                          });
                        },
                      ),

                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Action Buttons
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 6.h,
                    child: ElevatedButton(
                      onPressed:
                          _isFormValid && !_isLoading ? _handleContinue : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isFormValid
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.3),
                        foregroundColor: _isFormValid
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            )
                          : Text(
                              'Continue',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: _isFormValid
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                  ),
                            ),
                    ),
                  ),

                  SizedBox(height: 1.h),

                  // Skip Button
                  SizedBox(
                    width: double.infinity,
                    height: 6.h,
                    child: TextButton(
                      onPressed: _isLoading ? null : _handleSkip,
                      child: Text(
                        'Skip for now',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
