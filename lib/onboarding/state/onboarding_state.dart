import 'package:equatable/equatable.dart';
import 'package:ui_design/onboarding/model/user_registration.dart';


enum OnboardingStep {
  splash,
  welcome,
  savingGoals,
  security,
  referralCodeEmpty,
  referralCodeFilled,
  otpVerification,
  success,
  completeSignup,
  verifyBVN,
  cardDetails,
  loading,
  registrationSuccess,
}

enum OnboardingStatus { 
  initial, 
  loading, 
  success, 
  failure 
}

class OnboardingState extends Equatable {
  final OnboardingStep currentStep;
  final OnboardingStatus status;
  final UserRegistration userRegistration;
  final String? errorMessage;
  final String? successMessage;
  final int currentPageIndex;
  final String otpCode;
  final int resendCountdown;
  final bool canResendOTP;

  const OnboardingState({
    this.currentStep = OnboardingStep.splash,
    this.status = OnboardingStatus.initial,
    this.userRegistration = const UserRegistration(),
    this.errorMessage,
    this.successMessage,
    this.currentPageIndex = 0,
    this.otpCode = '',
    this.resendCountdown = 60,
    this.canResendOTP = false,
  });

  OnboardingState copyWith({
    OnboardingStep? currentStep,
    OnboardingStatus? status,
    UserRegistration? userRegistration,
    String? errorMessage,
    String? successMessage,
    int? currentPageIndex,
    String? otpCode,
    int? resendCountdown,
    bool? canResendOTP,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      status: status ?? this.status,
      userRegistration: userRegistration ?? this.userRegistration,
      errorMessage: errorMessage,
      successMessage: successMessage,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      otpCode: otpCode ?? this.otpCode,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      canResendOTP: canResendOTP ?? this.canResendOTP,
    );
  }

  bool get isLoading => status == OnboardingStatus.loading;
  bool get hasError => status == OnboardingStatus.failure;
  bool get isSuccess => status == OnboardingStatus.success;

  @override
  List<Object?> get props => [
        currentStep,
        status,
        userRegistration,
        errorMessage,
        successMessage,
        currentPageIndex,
        otpCode,
        resendCountdown,
        canResendOTP,
      ];

  @override
  String toString() {
    return 'OnboardingState(currentStep: $currentStep, status: $status, currentPageIndex: $currentPageIndex)';
  }
}