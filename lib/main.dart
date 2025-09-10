import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_design/onboarding/screens/card_details.dart';
import 'package:ui_design/onboarding/screens/loading.dart';
import 'package:ui_design/onboarding/screens/otp_verification.dart';
import 'package:ui_design/onboarding/screens/refferal_code.dart';
import 'package:ui_design/onboarding/screens/registration_successful.dart';
import 'package:ui_design/onboarding/screens/saving_goals.dart';
import 'package:ui_design/onboarding/screens/splash_screen.dart';
import 'package:ui_design/onboarding/screens/verifiation_sucess.dart';
import 'package:ui_design/onboarding/screens/verify_bvn.dart';
import 'package:ui_design/onboarding/screens/welcome_screen.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'CedarOaks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
      initialRoute: '/welcome',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/saving-goals': (context) => const SavingGoalsScreen(),
        //'/security-assurance': (context) => const SecurityAssuranceScreen(),
        '/referral-code': (context) => const ReferralCodeScreen(),
        '/otp-verification': (context) => const OTPVerificationScreen(),
        '/verification-success': (context) => const VerificationSuccessScreen(),
        //'/complete-signup': (context) => const CompleteSignupScreen(),
        '/verify-bvn': (context) => const VerifyBvnScreen(),
        '/card-details': (context) => const CardDetailsScreen(),
        '/loading': (context) => const LoadingScreen(),
        '/registration-successful': (context) =>
            const RegistrationSuccessfulScreen(),
        '/main-app': (context) =>
            const MainAppScreen(), // This is your main app after onboarding
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes if needed
        switch (settings.name) {
          case '/otp-verification':
            final args = settings.arguments as Map<String, dynamic>?;
            return MaterialPageRoute(
              builder: (context) => OTPVerificationScreen(),
            );
          default:
            return null;
        }
      },
      onUnknownRoute: (settings) {
        // Handle unknown routes
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      },
    );
  }
}

class MainAppScreen extends StatelessWidget {
  const MainAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('CedarOaks'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Welcome to CedarOaks!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Your onboarding is complete.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
