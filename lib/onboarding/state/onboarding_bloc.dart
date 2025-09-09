import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_design/onboarding/model/onboarding_events.dart';
import 'package:ui_design/onboarding/model/user_registration.dart';
import 'package:ui_design/onboarding/state/onboarding_state.dart';


class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  Timer? _resendTimer;

  OnboardingBloc() : super(const OnboardingState()) {
    on<NextStepEvent>(_onNextStep);
    on<PreviousStepEvent>(_onPreviousStep);
    on<GoToStepEvent>(_onGoToStep);
    on<UpdateUserDataEvent>(_onUpdateUserData);
    on<VerifyOTPEvent>(_onVerifyOTP);
    on<ResendOTPEvent>(_onResendOTP);
    on<CompleteRegistrationEvent>(_onCompleteRegistration);
    on<VerifyBVNEvent>(_onVerifyBVN);
    on<SubmitCardDetailsEvent>(_onSubmitCardDetails);
    on<SendVerificationLinkEvent>(_onSendVerificationLink);
    on<SkipOnboardingEvent>(_onSkipOnboarding);
    on<ResetOnboardingEvent>(_onResetOnboarding);
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }

  void _onNextStep(NextStepEvent event, Emitter<OnboardingState> emit) {
    final currentStep = state.currentStep;
    OnboardingStep? nextStep;

    switch (currentStep) {
      case OnboardingStep.splash:
        nextStep = OnboardingStep.welcome;
        break;
      case OnboardingStep.welcome:
        nextStep = OnboardingStep.savingGoals;
        break;
      case OnboardingStep.savingGoals:
        nextStep = OnboardingStep.security;
        break;
      case OnboardingStep.security:
        nextStep = OnboardingStep.referralCodeEmpty;
        break;
      case OnboardingStep.referralCodeEmpty:
        nextStep = OnboardingStep.referralCodeFilled;
        break;
      case OnboardingStep.referralCodeFilled:
        nextStep = OnboardingStep.otpVerification;
        break;
      case OnboardingStep.otpVerification:
        nextStep = OnboardingStep.success;
        break;
      case OnboardingStep.success:
        nextStep = OnboardingStep.completeSignup;
        break;
      case OnboardingStep.completeSignup:
        nextStep = OnboardingStep.verifyBVN;
        break;
      case OnboardingStep.verifyBVN:
        nextStep = OnboardingStep.cardDetails;
        break;
      case OnboardingStep.cardDetails:
        nextStep = OnboardingStep.loading;
        break;
      case OnboardingStep.loading:
        nextStep = OnboardingStep.registrationSuccess;
        break;
      default:
        return;
    }

    if (nextStep != null) {
      emit(state.copyWith(
        currentStep: nextStep,
        status: OnboardingStatus.initial,
        errorMessage: null,
      ));
    }
  }

  void _onPreviousStep(PreviousStepEvent event, Emitter<OnboardingState> emit) {
    final currentStep = state.currentStep;
    OnboardingStep? previousStep;

    switch (currentStep) {
      case OnboardingStep.welcome:
        previousStep = OnboardingStep.splash;
        break;
      case OnboardingStep.savingGoals:
        previousStep = OnboardingStep.welcome;
        break;
      case OnboardingStep.security:
        previousStep = OnboardingStep.savingGoals;
        break;
      case OnboardingStep.referralCodeFilled:
        previousStep = OnboardingStep.referralCodeEmpty;
        break;
      case OnboardingStep.otpVerification:
        previousStep = OnboardingStep.referralCodeFilled;
        break;
      case OnboardingStep.success:
        previousStep = OnboardingStep.otpVerification;
        break;
      case OnboardingStep.completeSignup:
        previousStep = OnboardingStep.success;
        break;
      case OnboardingStep.verifyBVN:
        previousStep = OnboardingStep.completeSignup;
        break;
      case OnboardingStep.cardDetails:
        previousStep = OnboardingStep.verifyBVN;
        break;
      default:
        return;
    }

    if (previousStep != null) {
      emit(state.copyWith(
        currentStep: previousStep,
        status: OnboardingStatus.initial,
        errorMessage: null,
      ));
    }
  }

  void _onGoToStep(GoToStepEvent event, Emitter<OnboardingState> emit) {
    final steps = OnboardingStep.values;
    if (event.stepIndex >= 0 && event.stepIndex < steps.length) {
      emit(state.copyWith(
        currentStep: steps[event.stepIndex],
        status: OnboardingStatus.initial,
        errorMessage: null,
      ));
    }
  }

  void _onUpdateUserData(UpdateUserDataEvent event, Emitter<OnboardingState> emit) {
    UserRegistration updatedRegistration;

    switch (event.field.toLowerCase()) {
      case 'firstname':
        updatedRegistration = state.userRegistration.copyWith(firstName: event.value);
        break;
      case 'lastname':
        updatedRegistration = state.userRegistration.copyWith(lastName: event.value);
        break;
      case 'phonenumber':
        updatedRegistration = state.userRegistration.copyWith(phoneNumber: event.value);
        break;
      case 'email':
        updatedRegistration = state.userRegistration.copyWith(email: event.value);
        break;
      case 'password':
        updatedRegistration = state.userRegistration.copyWith(password: event.value);
        break;
      case 'bvn':
        updatedRegistration = state.userRegistration.copyWith(bvn: event.value);
        break;
      case 'cardname':
        updatedRegistration = state.userRegistration.copyWith(cardName: event.value);
        break;
      case 'cardnumber':
        updatedRegistration = state.userRegistration.copyWith(cardNumber: event.value);
        break;
      case 'expirydate':
        updatedRegistration = state.userRegistration.copyWith(expiryDate: event.value);
        break;
      case 'cvv':
        updatedRegistration = state.userRegistration.copyWith(cvv: event.value);
        break;
      case 'billingaddress':
        updatedRegistration = state.userRegistration.copyWith(billingAddress: event.value);
        break;
      case 'referralcode':
        updatedRegistration = state.userRegistration.copyWith(referralCode: event.value);
        break;
      default:
        return;
    }

    emit(state.copyWith(userRegistration: updatedRegistration));
  }

  void _onVerifyOTP(VerifyOTPEvent event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(
      status: OnboardingStatus.loading,
      otpCode: event.otp,
    ));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, accept any 6-digit OTP
      if (event.otp.length == 6) {
        emit(state.copyWith(
          status: OnboardingStatus.success,
          currentStep: OnboardingStep.success,
          successMessage: 'OTP verified successfully',
        ));
      } else {
        emit(state.copyWith(
          status: OnboardingStatus.failure,
          errorMessage: 'Invalid OTP. Please try again.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Failed to verify OTP. Please try again.',
      ));
    }
  }

  void _onResendOTP(ResendOTPEvent event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(
      status: OnboardingStatus.loading,
      canResendOTP: false,
      resendCountdown: 60,
    ));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      emit(state.copyWith(
        status: OnboardingStatus.success,
        successMessage: 'OTP resent successfully',
      ));

      _startResendTimer(emit);
    } catch (e) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Failed to resend OTP. Please try again.',
      ));
    }
  }

  void _startResendTimer(Emitter<OnboardingState> emit) {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendCountdown > 0) {
        emit(state.copyWith(resendCountdown: state.resendCountdown - 1));
      } else {
        timer.cancel();
        emit(state.copyWith(canResendOTP: true));
      }
    });
  }

  void _onCompleteRegistration(CompleteRegistrationEvent event, Emitter<OnboardingState> emit) async {
    if (!state.userRegistration.isBasicInfoComplete) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Please fill in all required fields',
      ));
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      emit(state.copyWith(
        status: OnboardingStatus.success,
        currentStep: OnboardingStep.verifyBVN,
        successMessage: 'Registration completed successfully',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Registration failed. Please try again.',
      ));
    }
  }

  void _onVerifyBVN(VerifyBVNEvent event, Emitter<OnboardingState> emit) async {
    if (event.bvn.length != 11) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Please enter a valid 11-digit BVN',
      ));
      return;
    }

    emit(state.copyWith(
      status: OnboardingStatus.loading,
      userRegistration: state.userRegistration.copyWith(bvn: event.bvn),
    ));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 3));
      
      emit(state.copyWith(
        status: OnboardingStatus.success,
        currentStep: OnboardingStep.cardDetails,
        successMessage: 'BVN verified successfully',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'BVN verification failed. Please try again.',
      ));
    }
  }

  void _onSubmitCardDetails(SubmitCardDetailsEvent event, Emitter<OnboardingState> emit) async {
    if (!state.userRegistration.isCardDetailsComplete) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Please fill in all card details',
      ));
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.loading));

    try {
      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 4));
      
      emit(state.copyWith(
        status: OnboardingStatus.success,
        currentStep: OnboardingStep.registrationSuccess,
        successMessage: 'Payment processed successfully',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Payment processing failed. Please try again.',
      ));
    }
  }

  void _onSendVerificationLink(SendVerificationLinkEvent event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(
      status: OnboardingStatus.loading,
      userRegistration: state.userRegistration.copyWith(referralCode: event.referralCode),
    ));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      emit(state.copyWith(
        status: OnboardingStatus.success,
        currentStep: OnboardingStep.otpVerification,
        successMessage: 'Verification link sent successfully',
        canResendOTP: false,
        resendCountdown: 60,
      ));

      _startResendTimer(emit);
    } catch (e) {
      emit(state.copyWith(
        status: OnboardingStatus.failure,
        errorMessage: 'Failed to send verification link. Please try again.',
      ));
    }
  }

  void _onSkipOnboarding(SkipOnboardingEvent event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentStep: OnboardingStep.referralCodeEmpty));
  }

  void _onResetOnboarding(ResetOnboardingEvent event, Emitter<OnboardingState> emit) {
    _resendTimer?.cancel();
    emit(const OnboardingState());
  }
}