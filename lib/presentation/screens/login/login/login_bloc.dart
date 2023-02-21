
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/app_repository.dart';
import '../../../../data/repository/auth_repository/auth_repo.dart';
import '../../../../utils/validator.dart';
import 'bloc.dart';



class LoginBloc extends Bloc<LoginEvent,LoginState>
{
  final AuthRepository _authRepository = AppRepository.authRepository;
   LoginBloc() : super(LoginState.empty())
  {
    on<EmailChange>((event, emit) async =>
    await _mapEmailChangeToState(emit, event, event.email));
    on<PasswordChange>((event, emit) async =>
    await _mapPasswordChangedToState(emit, event, event.password));
    on<LoginCredential>((event, emit) async => await
    _mapLoginWithCredentialToState(emit, event, event.email, event.password));
  }

  Future<void> _mapEmailChangeToState(Emitter<LoginState> emit,
      EmailChange event,String  email) async
  {
    emit(state.update(isEmailValid: UtilValidators.isValidEmail(email)));
  }
  Future<void> _mapPasswordChangedToState(Emitter<LoginState> emit,
      PasswordChange event,String password) async
  {
    emit(state.update(isPasswordValid: UtilValidators.isValidPassword(password)));
  }
  Future<void> _mapLoginWithCredentialToState(Emitter<LoginState> emit,
      LoginCredential event,String email,String password) async
  {
    try
    {
      emit(LoginState.logging());
      await _authRepository.logInWithEmail(email, password);
      bool isLoggedIn = _authRepository.isLogged();
      if(isLoggedIn == true)
      {
        emit(LoginState.success());
      }
      else
        {
          final message = _authRepository.authException;
          emit(LoginState.fail(message));
        }
    } catch (e) {
      emit(LoginState.fail("Đăng nhập thất bại"));
    }


  }
}

