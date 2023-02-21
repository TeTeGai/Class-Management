
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class JoinClassState{
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;

  JoinClassState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.message});


  factory JoinClassState.emty()
  {
    return JoinClassState(
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        message: "",
    );
  }

  factory JoinClassState.joining(String message)
  {
    return JoinClassState(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      message: message,
    );
  }

  factory JoinClassState.fail(String message)
  {
    return JoinClassState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      message: message,
    );
  }

  factory JoinClassState.success(String message)
  {
    return JoinClassState(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: message,
    );
  }

}
