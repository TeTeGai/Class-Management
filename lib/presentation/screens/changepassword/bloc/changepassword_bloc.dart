import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/utils/validator.dart';

import '../../../../data/model/user_model.dart';
import '../../../../data/repository/repository.dart';
import 'bloc.dart';

class ChangePassWordBloc extends Bloc<ChangePassWordEvent,ChangePassWordState> {
  final AuthRepository _authRepository = AppRepository.authRepository;
  ChangePassWordBloc(): super(ChangePassWordState.empty()){


    on<OldPasswordChange>((event, emit) async
    {
      await _mapOldPassWordChangeToState(emit,event);
    });

    on<NewPasswordChange>((event, emit) async
    {
      await _mapNewPassWordChangeToState(emit,event);
    });

    on<ConfirmNewPasswordChange>((event, emit) async
    {
      await _mapConfirmPassWordChangeToState(
        emit,
        event,
      );
    });

    on<Submitted>((event, emit) async
    {
      await _mapFormSubmittedToState(
        emit,
        event,
      );
    });
  }

  Future<void> _mapOldPassWordChangeToState(Emitter emit, OldPasswordChange event) async
  {
    var isPasswordValid = UtilValidators.isValidPassword(event.OldPassword);
    emit(state.update(isOldPasswordValid: isPasswordValid));
  }

  Future<void> _mapNewPassWordChangeToState(Emitter emit, NewPasswordChange event) async
  {
    var isPasswordValid = UtilValidators.isValidPassword(event.NewPassword);
    emit(state.update(isNewPasswordValid: isPasswordValid));
  }

  Future<void> _mapConfirmPassWordChangeToState(Emitter  emit, ConfirmNewPasswordChange event) async
  {
    var isConfirmPasswordValid = UtilValidators.isValidPassword(event.ConfirmNewPassword);
    var isMatch = true;
    if(event.NewPassword.isNotEmpty )
    {
      isMatch = event.NewPassword == event.ConfirmNewPassword;
    }
    emit(state.update(isConfirmNewPasswordValid: isConfirmPasswordValid && isMatch));
  }

  Future<void> _mapFormSubmittedToState(Emitter emit, Submitted event,) async
  {
    try
    {
      emit(ChangePassWordState.changing());
      try{
        if(event.password == event.confirmPassword)
        await _authRepository.updateUserPassword(event.oldPassword,event.password,event.contex);
        emit(ChangePassWordState.success());
      }
      catch(e){
        emit(ChangePassWordState.fail("Thay đổi mật khẩu thất bại"));
      }

    }catch (e) {
      emit(ChangePassWordState.fail("Thay đổi mật khẩu thất bại"));
    }

  }

}