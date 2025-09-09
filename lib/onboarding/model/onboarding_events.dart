import 'package:equatable/equatable.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class NextStepEvent extends OnboardingEvent {
  const NextStepEvent();
}

class PreviousStepEvent extends OnboardingEvent {
  const PreviousStepEvent();
}

class GoToStepEvent extends OnboardingEvent {
  final int stepIndex;

  const GoToStepEvent(this.stepIndex);

  @override
  List<Object?> get props => [stepIndex];
}

class UpdateUserDataEvent extends OnboardingEvent {
  final String field;
  final String value;

  const UpdateUserDataEvent(this.field, this.value);

  @override
  List<Object?> get props => [field, value];
}

class VerifyOTPEvent extends OnboardingEvent {
  final String otp;

  const VerifyOTPEvent(this.otp);

  @override
  List<Object?> get props => [otp];
}

class ResendOTPEvent extends OnboardingEvent {
  const ResendOTPEvent();
}

class CompleteRegistrationEvent extends OnboardingEvent {
  const CompleteRegistrationEvent();
}

class VerifyBVNEvent extends OnboardingEvent {
  final String bvn;

  const VerifyBVNEvent(this.bvn);

  @override
  List<Object?> get props => [bvn];
}

class SubmitCardDetailsEvent extends OnboardingEvent {
  const SubmitCardDetailsEvent();
}

class SendVerificationLinkEvent extends OnboardingEvent {
  final String referralCode;

  const SendVerificationLinkEvent(this.referralCode);

  @override
  List<Object?> get props => [referralCode];
}

class SkipOnboardingEvent extends OnboardingEvent {
  const SkipOnboardingEvent();
}

class ResetOnboardingEvent extends OnboardingEvent {
  const ResetOnboardingEvent();
}