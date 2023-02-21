import 'package:meta/meta.dart';

@immutable
class ChangePassWordState{
  final bool isOldPasswordValid;
  final bool isNewPasswordValid;
  final bool isConfirmNewPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;

  bool get isFormValid =>
       isNewPasswordValid && isConfirmNewPasswordValid;
  ChangePassWordState(
      {
        required this.isOldPasswordValid,
        required this.isNewPasswordValid,
        required this.isConfirmNewPasswordValid,
        required this.isSubmitting,
        required this.isSuccess,
        required this.isFailure,
        this.message});

  factory ChangePassWordState.empty()
  {
    return ChangePassWordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isConfirmNewPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message:"",
    );
  }

  factory ChangePassWordState.changing()
  {
    return ChangePassWordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isConfirmNewPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      message:"Đang đăng ký ...",
    );
  }

  factory ChangePassWordState.fail(String message)
  {
    return ChangePassWordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isConfirmNewPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      message:message,
    );
  }

  factory ChangePassWordState.success()
  {
    return ChangePassWordState(
      isOldPasswordValid: true,
      isNewPasswordValid: true,
      isConfirmNewPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: "Đăng ký thành công",
    );
  }

  ChangePassWordState update({bool? isOldPasswordValid,bool? isNewPasswordValid, bool? isConfirmNewPasswordValid})
  {
    return cloneWith(
      isOldPasswordValid: isOldPasswordValid,
      isNewPasswordValid: isNewPasswordValid,
      isConfirmNewPasswordValid: isConfirmNewPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  ChangePassWordState cloneWith(
  {
     bool? isOldPasswordValid,
     bool? isNewPasswordValid,
     bool? isConfirmNewPasswordValid,
     bool? isSubmitting,
     bool? isSuccess,
     bool? isFailure,
     String? message,
  }){
    return ChangePassWordState(
        isOldPasswordValid: isOldPasswordValid ?? this.isOldPasswordValid,
        isNewPasswordValid: isNewPasswordValid ?? this.isNewPasswordValid,
        isConfirmNewPasswordValid: isConfirmNewPasswordValid ?? this.isConfirmNewPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
}