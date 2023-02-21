
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class EditClassState{
  final bool isClasVaild;
  final bool isGradeVaild;
  final bool isSchoolVaild;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;

  EditClassState({
    required this.isClasVaild,
    required this.isGradeVaild,
    required this.isSchoolVaild,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.message});

  bool get isFormValid => isClasVaild && isGradeVaild && isSchoolVaild;

  factory EditClassState.emty()
  {
    return EditClassState(
        isClasVaild: true,
        isGradeVaild: true,
        isSchoolVaild: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        message: "",
    );
  }

  factory EditClassState.creating()
  {
    return EditClassState(
      isClasVaild: true,
      isGradeVaild: true,
      isSchoolVaild: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      message: "Đang chỉnh sửa thông tin ...",
    );
  }

  factory EditClassState.fail(String message)
  {
    return EditClassState(
      isClasVaild: true,
      isGradeVaild: true,
      isSchoolVaild: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      message: message,
    );
  }

  factory EditClassState.success()
  {
    return EditClassState(
      isClasVaild: true,
      isGradeVaild: true,
      isSchoolVaild: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: "Chỉnh sửa thành công",
    );
  }

  EditClassState update({bool? isClasVaild,bool? isGradeVaild, bool? isSchoolVaild})
  {
    return cloneWith(
      isClasVaild: isClasVaild,
      isGradeVaild: isGradeVaild,
      isSchoolVaild: isSchoolVaild,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  EditClassState cloneWith(
      {
        bool? isClasVaild,
        bool? isGradeVaild,
        bool? isSchoolVaild,
        bool? isSubmitting,
        bool? isSuccess,
        bool? isFailure,
        String? message,
      }){
    return EditClassState(
        isClasVaild: isClasVaild ?? this.isClasVaild,
        isGradeVaild: isGradeVaild ?? this.isGradeVaild,
        isSchoolVaild: isSchoolVaild ?? this.isSchoolVaild,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
}