import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_design/core/constants/app_colors.dart';
import 'package:ui_design/core/constants/app_strings.dart';
import 'package:ui_design/core/widgets/custom_button.dart';
import 'package:ui_design/onboarding/model/onboarding_events.dart';
import 'package:ui_design/onboarding/state/onboarding_bloc.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              _buildStatusIndicator(context, 1),
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
                        Colors.blue.shade50,
                        Colors.green.shade50,
                        Colors.purple.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 120,
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Content
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppStrings.welcomeTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.welcomeSubtitle,
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
}