import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_design/core/constants/app_colors.dart';
import 'package:ui_design/core/widgets/custom_button.dart';
import 'package:ui_design/core/widgets/custom_text_field.dart';


class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _addressController = TextEditingController();
  
  bool _rememberCard = false;

  @override
  void dispose() {
    _nameController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String _formatCardNumber(String value) {
    value = value.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    final RegExp regExp = RegExp(r'.{1,4}');
    Iterable<RegExpMatch> matches = regExp.allMatches(value);
    return matches.map((match) => match.group(0)).join(' ');
  }

  String _formatExpiryDate(String value) {
    if (value.length >= 2 && !value.contains('/')) {
      return '${value.substring(0, 2)}/${value.substring(2)}';
    }
    return value;
  }

  void _proceedToNext() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushNamed(context, '/loading');
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
          'STEP 5/5',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Registration fee',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Card details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please provide your payment details below. A one-time registration fee of 2000 naira will be charged to your card.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Name on card',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: 'Name on card',
                controller: _nameController,
                hint: 'Mary Ellen Scott',
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the name on card';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Card Number',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: 'Card Number',
                controller: _cardNumberController,
                hint: '4379 3234 5106 0922',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    String text = _formatCardNumber(newValue.text);
                    return TextEditingValue(
                      text: text,
                      selection: TextSelection.collapsed(offset: text.length),
                    );
                  }),
                ],
                // Removed prefixIcon as CustomTextField does not support it
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter card number';
                  }
                  String cleanValue = value!.replaceAll(' ', '');
                  if (cleanValue.length != 16) {
                    return 'Card number must be 16 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expiry Date',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          label: 'Expiry Date',
                          controller: _expiryController,
                          hint: '01/26',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            TextInputFormatter.withFunction((oldValue, newValue) {
                              String text = _formatExpiryDate(newValue.text);
                              return TextEditingValue(
                                text: text,
                                selection: TextSelection.collapsed(offset: text.length),
                              );
                            }),
                          ],
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Required';
                            }
                            if (!value!.contains('/') || value.length != 5) {
                              return 'Invalid format';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CVV',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          label: 'CVV',
                          controller: _cvvController,
                          hint: '123',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Required';
                            }
                            if (value!.length != 3) {
                              return 'Invalid CVV';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _rememberCard,
                    onChanged: (value) {
                      setState(() {
                        _rememberCard = value ?? false;
                      });
                    },
                    activeColor: AppColors.primary,
                  ),
                  const Expanded(
                    child: Text(
                      'Remember this card for monthly auto charges',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Billing Address',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: 'Billing Address',
                controller: _addressController,
                hint: 'Enter your billing address',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter billing address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Navigate to registration fee info
                  },
                  child: const Text(
                    'Why is a Registration fee?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Proceed',
                onPressed: _proceedToNext,
                backgroundColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}