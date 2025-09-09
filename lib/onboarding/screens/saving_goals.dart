import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_design/core/constants/app_colors.dart';
import 'package:ui_design/core/constants/app_strings.dart';
import 'package:ui_design/core/widgets/custom_button.dart';
import 'package:ui_design/onboarding/model/onboarding_events.dart';
import 'package:ui_design/onboarding/state/onboarding_bloc.dart';


class SavingGoalsScreen extends StatelessWidget {
  const SavingGoalsScreen({super.key});

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
              _buildStatusIndicator(context, 2),
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
                        Colors.green.shade50,
                        Colors.blue.shade50,
                        Colors.amber.shade50,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,
                        left: 30,
                        child: _buildSavingIcon(Icons.savings, Colors.green),
                      ),
                      Positioned(
                        top: 60,
                        right: 40,
                        child: _buildSavingIcon(Icons.trending_up, Colors.blue),
                      ),
                      Positioned(
                        bottom: 50,
                        left: 50,
                        child: _buildSavingIcon(Icons.account_balance, Colors.purple),
                      ),
                      Center(
                        child: Icon(
                          Icons.track_changes,
                          size: 80,
                          color: AppColors.primary.withOpacity(0.6),
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
                      AppStrings.savingGoalsTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.savingGoalsSubtitle,
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

  Widget _buildSavingIcon(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }
}