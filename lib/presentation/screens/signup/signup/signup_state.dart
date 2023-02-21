import 'package:meta/meta.dart';

@immutable
class SignUpState{
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;

  bool get isFormValid =>
      isEmailValid && isPasswordValid && isConfirmPasswordValid;
  SignUpState(
      {
        required this.isEmailValid,
        required this.isPasswordValid,
        required this.isConfirmPasswordValid,
        required this.isSubmitting,
        required this.isSuccess,
        required this.isFailure,
        this.message});

  factory SignUpState.empty()
  {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message:"",
    );
  }

  factory SignUpState.logging()
  {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      message:"Đang đăng ký ...",
    );
  }

  factory SignUpState.fail(String message)
  {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      message:message,
    );
  }

  factory SignUpState.success()
  {
    return SignUpState(
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: "Đăng ký thành công",
    );
  }

  SignUpState update({bool? isEmail,bool? isPasswordValid, bool? isConfirmPasswordValid})
  {
    return cloneWith(
      isEmail: isEmail,
      isPasswordValid: isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  SignUpState cloneWith(
  {
     bool? isEmail,
     bool? isPasswordValid,
     bool? isConfirmPasswordValid,
     bool? isSubmitting,
     bool? isSuccess,
     bool? isFailure,
     String? message,
  }){
    return SignUpState(
        isEmailValid: isEmail ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
}