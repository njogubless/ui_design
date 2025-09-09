import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_design/core/constants/app_colors.dart';
import 'package:ui_design/core/constants/app_strings.dart';
import 'package:ui_design/core/widgets/custom_button.dart';
import 'package:ui_design/core/widgets/custom_text_field.dart';
import 'package:ui_design/onboarding/model/onboarding_events.dart';
import 'package:ui_design/onboarding/state/onboarding_bloc.dart';
import 'package:ui_design/onboarding/state/onboarding_state.dart';


class ReferralCodeScreen extends StatefulWidget {
  const ReferralCodeScreen({super.key});

  @override
  State<ReferralCodeScreen> createState() => _ReferralCodeScreenState();
}

class _ReferralCodeScreenState extends State<ReferralCodeScreen> {
  final TextEditingController _referralController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _referralController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        final isFilledState = state.currentStep == OnboardingStep.referralCodeFilled;
        
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<OnboardingBloc>().add(const PreviousStepEvent());
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Expanded(
                        child: Text(
                          'Verification',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance the back button
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to CedarOaks!',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          AppStrings.enterReferralCode,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        if (isFilledState) ...[
                          // Filled State - Show referral code
                          CustomTextField(
                            label: AppStrings.referralCode,
                            controller: _referralController,
                            hint: 'XYZ-2AA',
                            onChanged: (value) {
                              context.read<OnboardingBloc>().add(
                                UpdateUserDataEvent('referralcode', value),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: 'Email or Phone number',
                            controller: _phoneController,
                            hint: '09133982012',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ] else ...[
                          // Empty State - Just phone/email input
                          CustomTextField(
                            label: 'Email or Phone number',
                            controller: _phoneController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                        
                        const Spacer(),
                        
                        // Send verification link button
                        CustomButton(
                          text: 'Send verification link',
                          isLoading: state.isLoading,
                          onPressed: () {
                            if (isFilledState) {
                              context.read<OnboardingBloc>().add(
                                SendVerificationLinkEvent(_referralController.text),
                              );
                            } else {
                              // Move to filled state first
                              context.read<OnboardingBloc>().add(const NextStepEvent());
                            }
                          },
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Resend link
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Handle resend
                            },
                            child: const Text(
                              'Resend in 60s',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 14,
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
          ),
        );
      },
    );
  }
}