import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_design/core/constants/app_colors.dart';
import 'package:ui_design/core/constants/app_strings.dart';
import 'package:ui_design/core/widgets/custom_button.dart';
import 'package:ui_design/onboarding/model/onboarding_events.dart';
import 'package:ui_design/onboarding/state/onboarding_bloc.dart';


class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Status Bar
              _buildStatusIndicator(context, 3),
              const SizedBox(height: 40),
              
              // Illustration Area
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.indigo.shade50,
                        Colors.cyan.shade50,
                        Colors.teal.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        right: 20,
                        child: _buildSecurityIcon(Icons.security, Colors.indigo),
                      ),
                      Positioned(
                        top: 80,
                        left: 20,
                        child: _buildSecurityIcon(Icons.verified_user, Colors.cyan),
                      ),
                      Positioned(
                        bottom: 40,
                        right: 60,
                        child: _buildSecurityIcon(Icons.lock, Colors.teal),
                      ),
                      Positioned(
                        bottom: 80,
                        left: 40,
                        child: _buildSecurityIcon(Icons.shield, Colors.green),
                      ),
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.security,
                            size: 50,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Content
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppStrings.securityTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.securitySubtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const Spacer(),
                    
                    // Buttons
                    CustomButton(
                      text: AppStrings.createAccount,
                      onPressed: () {
                        context.read<OnboardingBloc>().add(const NextStepEvent());
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: AppStrings.login,
                      isOutlined: true,
                      onPressed: () {
                        // Handle login navigation
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context, int currentStep) {
    return Row(
      children: [
        Text(
          '${currentStep.toString().padLeft(2, '0')}/10',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: LinearProgressIndicator(
            value: currentStep / 10,
            backgroundColor: AppColors.borderColor,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityIcon(IconData icon, Color color) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }
}