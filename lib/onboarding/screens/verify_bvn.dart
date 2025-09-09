import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_design/core/constants/app_colors.dart';
import 'package:ui_design/core/widgets/custom_button.dart';
import 'package:ui_design/core/widgets/custom_text_field.dart';


class VerifyBvnScreen extends StatefulWidget {
  const VerifyBvnScreen({super.key});

  @override
  State<VerifyBvnScreen> createState() => _VerifyBvnScreenState();
}

class _VerifyBvnScreenState extends State<VerifyBvnScreen> {
  final _bvnController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _bvnController.dispose();
    super.dispose();
  }

  void _verifyBvn() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, '/card-details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'STEP 4/5',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'BVN',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'You need to verify your BVN to gain full access to the app',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your 10-digit Bank Verification Number',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'BVN',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: 'BVN',
                controller: _bvnController,
                hint: 'Enter your BVN',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your BVN';
                  }
                  if (value!.length != 11) {
                    return 'BVN must be 11 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Verify BVN',
                onPressed: _verifyBvn,
                backgroundColor: AppColors.primary,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}