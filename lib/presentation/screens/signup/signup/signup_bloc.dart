import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/utils/validator.dart';

import '../../../../data/model/user_model.dart';
import '../../../../data/repository/repository.dart';
import 'bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent,SignUpState> {
  final AuthRepository _authRepository = AppRepository.authRepository;
  SignUpBloc(): super(SignUpState.empty()){
    on<EmailChange>((event, emit) async
    {
      await _mapEmailChangeToState(emit,event,event.email);

    });

    on<PasswordChange>((event, emit) async
    {
      await _mapPassWordChangeToState(emit,event,event.password);
    });

    on<ConfirmPasswordChange>((event, emit) async
    {
      await _mapConfirmPassWordChangeToState(
        emit,
        event,
        event.password,
        event.confirmPassword,
      );
    });

    on<Submitted>((event, emit) async
    {
      await _mapFormSubmittedToState(
        emit,
        event,
        event.newUser,
        event.password,
        event.confirmPassword,
      );
    });
  }

  Future<void> _mapEmailChangeToState(Emitter<SignUpState> emit, EmailChange event,String  email) async
  {
    var emailValid = UtilValidators.isValidEmail(email);
    emit(state.update(isEmail: emailValid));
  }

  Future<void> _mapPassWordChangeToState(Emitter<SignUpState> emit, PasswordChange event,String  password) async
  {
    var isPasswordValid = UtilValidators.isValidPassword(password);
    emit(state.update(isPasswordValid: isPasswordValid));
  }

  Future<void> _mapConfirmPassWordChangeToState(Emitter<SignUpState> emit, ConfirmPasswordChange event,String password,String confirmPassword) async
  {
    var isConfirmPasswordValid = UtilValidators.isValidPassword(confirmPassword);
    var isMatch = true;
    if(password.isNotEmpty )
    {
      isMatch = password == confirmPassword;
    }
    emit(state.update(isConfirmPasswordValid: isConfirmPasswordValid && isMatch));
  }

  Future<void> _mapFormSubmittedToState(Emitter<SignUpState> emit, Submitted event,UserModel newUser, String password, String confirmPassword,) async
  {
    try
    {
      emit(SignUpState.logging());

      await _authRepository.signUp(newUser, password);
      bool isLoggedIn = _authRepository.isLogged();
      if (isLoggedIn) {
        emit(SignUpState.success());
      } else {
        final message = _authRepository.authException;
        emit(SignUpState.fail(message));
      }
    }catch (e) {
      emit(SignUpState.fail("Đăng ký thất bại"));
    }

  }

}