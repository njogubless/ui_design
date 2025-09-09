import 'package:flutter/material.dart';
import 'package:ui_design/core/constants/app_colors.dart';
import 'package:ui_design/core/widgets/custom_button.dart';


class RegistrationSuccessfulScreen extends StatelessWidget {
  const RegistrationSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Registration successful',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Thank you for choosing to join our community! We look forward to having you on board and hope you enjoy all that our platform has to offer.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                text: 'Proceed',
                onPressed: () {
                  // Navigate to main app or dashboard
                  Navigator.pushNamedAndRemoveUntil(
                    context, 
                    '/main-app', 
                    (route) => false,
                  );
                },
                backgroundColor: AppColors.primary,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}