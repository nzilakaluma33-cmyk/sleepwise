import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class PersonalInfoFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final String selectedGender;
  final String selectedWeightUnit;
  final String selectedHeightUnit;
  final List<String> genderOptions;
  final Function(String) onGenderChanged;
  final Function(String) onWeightUnitChanged;
  final Function(String) onHeightUnitChanged;
  final VoidCallback onFormChanged;

  const PersonalInfoFormWidget({
    super.key,
    required this.nameController,
    required this.ageController,
    required this.weightController,
    required this.heightController,
    required this.selectedGender,
    required this.selectedWeightUnit,
    required this.selectedHeightUnit,
    required this.genderOptions,
    required this.onGenderChanged,
    required this.onWeightUnitChanged,
    required this.onHeightUnitChanged,
    required this.onFormChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name Field
        _buildFormCard(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name *',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 1.h),
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Enter your full name',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'person',
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (_) => onFormChanged(),
              ),
            ],
          ),
        ),

        SizedBox(height: 2.h),

        // Age Field
        _buildFormCard(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Age *',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 1.h),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: InputDecoration(
                  hintText: 'Enter your age',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'cake',
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your age';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age < 18 || age > 100) {
                    return 'Please enter a valid age (18-100)';
                  }
                  return null;
                },
                onChanged: (_) => onFormChanged(),
              ),
            ],
          ),
        ),

        SizedBox(height: 2.h),

        // Gender Selection
        _buildFormCard(
          context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gender *',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 1.h),
              ...genderOptions.map((gender) => RadioListTile<String>(
                    title: Text(
                      gender,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    value: gender,
                    groupValue: selectedGender,
                    onChanged: (value) {
                      if (value != null) {
                        onGenderChanged(value);
                        onFormChanged();
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  )),
            ],
          ),
        ),

        SizedBox(height: 2.h),

        // Weight and Height Row
        Row(
          children: [
            // Weight Field
            Expanded(
              child: _buildFormCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight *',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,1}')),
                            ],
                            decoration: const InputDecoration(
                              hintText: '70',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            onChanged: (_) => onFormChanged(),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedWeightUnit,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                            ),
                            items: ['kg', 'lbs']
                                .map((unit) => DropdownMenuItem(
                                      value: unit,
                                      child: Text(unit),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                onWeightUnitChanged(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 3.w),

            // Height Field
            Expanded(
              child: _buildFormCard(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Height *',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,1}')),
                            ],
                            decoration: const InputDecoration(
                              hintText: '175',
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            onChanged: (_) => onFormChanged(),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedHeightUnit,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                            ),
                            items: ['cm', 'ft']
                                .map((unit) => DropdownMenuItem(
                                      value: unit,
                                      child: Text(unit),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                onHeightUnitChanged(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
