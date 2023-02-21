
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AddClassState{
  final bool isClasVaild;
  final bool isGradeVaild;
  final bool isSchoolVaild;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;

  AddClassState({
    required this.isClasVaild,
    required this.isGradeVaild,
    required this.isSchoolVaild,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.message});

  bool get isFormValid => isClasVaild && isGradeVaild && isSchoolVaild;

  factory AddClassState.emty()
  {
    return AddClassState(
        isClasVaild: true,
        isGradeVaild: true,
        isSchoolVaild: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        message: "",
    );
  }

  factory AddClassState.creating()
  {
    return AddClassState(
      isClasVaild: true,
      isGradeVaild: true,
      isSchoolVaild: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      message: "Đang tạo lớp ...",
    );
  }

  factory AddClassState.fail(String message)
  {
    return AddClassState(
      isClasVaild: true,
      isGradeVaild: true,
      isSchoolVaild: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      message: message,
    );
  }

  factory AddClassState.success()
  {
    return AddClassState(
      isClasVaild: true,
      isGradeVaild: true,
      isSchoolVaild: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: "Tạo lớp thành công",
    );
  }

  AddClassState update({bool? isClasVaild,bool? isGradeVaild, bool? isSchoolVaild})
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

  AddClassState cloneWith(
      {
        bool? isClasVaild,
        bool? isGradeVaild,
        bool? isSchoolVaild,
        bool? isSubmitting,
        bool? isSuccess,
        bool? isFailure,
        String? message,
      }){
    return AddClassState(
        isClasVaild: isClasVaild ?? this.isClasVaild,
        isGradeVaild: isGradeVaild ?? this.isGradeVaild,
        isSchoolVaild: isSchoolVaild ?? this.isSchoolVaild,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
}