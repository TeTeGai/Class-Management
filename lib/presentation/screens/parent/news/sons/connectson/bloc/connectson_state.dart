
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class ConnectSonState{
  final bool isIdVaild;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? message;

  ConnectSonState({
    required this.isIdVaild,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.message});

  bool get isFormValid => isIdVaild;

  factory ConnectSonState.emty()
  {
    return ConnectSonState(
         isIdVaild: true,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        message: "",
    );
  }

  factory ConnectSonState.joining(String message)
  {
    return ConnectSonState(
      isIdVaild: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: message,
    );
  }

  factory ConnectSonState.fail(String message)
  {
    return ConnectSonState(
      isIdVaild: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      message: message,
    );
  }

  factory ConnectSonState.success(String message)
  {
    return ConnectSonState(
      isIdVaild: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      message: message,
    );
  }
  ConnectSonState update({bool? isIdVaild})
  {
    return cloneWith(
      isIdVaild: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      message: "",
    );
  }

  ConnectSonState cloneWith(
      {
        bool? isIdVaild,
        bool? isSubmitting,
        bool? isSuccess,
        bool? isFailure,
        String? message,
      }){
    return ConnectSonState(
        isIdVaild: isIdVaild ?? this.isIdVaild,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure
    );
  }
}
