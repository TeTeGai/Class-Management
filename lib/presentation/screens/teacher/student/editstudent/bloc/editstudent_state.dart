
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class EditStudentState{
  final bool isNameVaild;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;

  EditStudentState({
    required this.isNameVaild,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.message});

  bool get isFormValid => isNameVaild;

  factory EditStudentState.emty()
  {
    return EditStudentState(
      isNameVaild: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        message: "",
    );
  }

  factory EditStudentState.creating()
  {
    return EditStudentState(
      isNameVaild: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      message: "Đang chỉnh sửa thông tin ...",
    );
  }

  factory EditStudentState.fail(String message)
  {
    return EditStudentState(
      isNameVaild: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      message: message,
    );
  }

  factory EditStudentState.success()
  {
    return EditStudentState(
      isNameVaild: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: "Chỉnh sửa thành công",
    );
  }

  EditStudentState update({bool? isNameVaild})
  {
    return cloneWith(
      isNameVaild: isNameVaild,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  EditStudentState cloneWith(
      {
        bool? isNameVaild,
        bool? isSubmitting,
        bool? isSuccess,
        bool? isFailure,
        String? message,
      }){
    return EditStudentState(
        isNameVaild: isNameVaild ?? this.isNameVaild,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
}