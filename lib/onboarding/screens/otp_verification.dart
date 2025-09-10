import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ui_design/core/constants/app_colors.dart';
import 'package:ui_design/core/constants/app_strings.dart';
import 'package:ui_design/core/widgets/custom_button.dart';
import 'package:ui_design/onboarding/model/onboarding_events.dart';
import 'package:ui_design/onboarding/state/onboarding_bloc.dart';
import 'package:ui_design/onboarding/state/onboarding_state.dart';


class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  String _currentOTP = '';

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
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
                      Text(
                        'STEP 2/5',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'OTP',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                        
                        Text(
                          '${AppStrings.enterPhoneForOTP}\n+2349133982012',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // OTP Pin Code Field
                        PinCodeTextField(
                          appContext: context,
                          length: 6,
                          controller: _otpController,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 50,
                            fieldWidth: 45,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            activeColor: AppColors.primary,
                            inactiveColor: AppColors.borderColor,
                            selectedColor: AppColors.primary,
                          ),
                          enableActiveFill: true,
                          onCompleted: (value) {
                            setState(() {
                              _currentOTP = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              _currentOTP = value;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Verify Button
                        CustomButton(
                          text: AppStrings.verify,
                          isLoading: state.isLoading,
                          onPressed: _currentOTP.length == 6
                              ? () {
                                  context.read<OnboardingBloc>().add(
                                    VerifyOTPEvent(_currentOTP),
                                  );
                                }
                              : null,
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Resend OTP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!state.canResendOTP) ...[
                              Text(
                                '${AppStrings.resendIn} ${state.resendCountdown}s',
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ] else ...[
                              TextButton(
                                onPressed: () {
                                  context.read<OnboardingBloc>().add(const ResendOTPEvent());
                                },
                                child: const Text(
                                  'Resend link',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        
                        const Spacer(),
                        
                        // Error Message
                        if (state.hasError && state.errorMessage != null)
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.error.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.error.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: AppColors.error,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    state.errorMessage!,
                                    style: const TextStyle(
                                      color: AppColors.error,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
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