import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/auth/bloc.dart';
import '../../../data/repository/app_repository.dart';
import '../../../data/repository/repository.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>
{
   AuthBloc() :super(Unauthenticated())
  {
    on<AuthenticationStarted>((event, emit) async => await _mapAppStartedToState(emit,event));

    on<LoggedIn>((event, emit) async => await _mapLoggedInToState(emit,event));
    on<LoggedOut>((event, emit) async => await _mapLoggedOutToState(emit,event));
    on<UpdateAvatar>((event, emit) async => await _mapUpdateAvatarToState(emit,event));

  }
}
Future <void> _mapLoggedInToState(Emitter<AuthState> emit, LoggedIn event) async {
  final AuthRepository _authRepository = AppRepository.authRepository;
  String role = await _authRepository.checkRole(_authRepository.loggedFirebaseUser.uid);
  if(role =="teacher")
  {
    emit(Authenticated(_authRepository.loggedFirebaseUser));
  }
  else
  {
    emit(AuthenticatedParent(_authRepository.loggedFirebaseUser));
  }
}
Future <void> _mapLoggedOutToState(Emitter<AuthState> emit, LoggedOut event) async {
  final AuthRepository _authRepository = AppRepository.authRepository;
  emit(Unauthenticated());
  _authRepository.logOut();
}

Future <void> _mapUpdateAvatarToState(Emitter emit, UpdateAvatar event) async {
  final AuthRepository _authRepository = AppRepository.authRepository;
  _authRepository.updateUserAvatar(event.img);
}

Future <void> _mapAppStartedToState(Emitter<AuthState> emit, AuthenticationStarted event) async {
  final AuthRepository _authRepository = AppRepository.authRepository;
  try {
    bool isLoggedIn = _authRepository.isLogged();

    //For display splash screen
    await Future.delayed(Duration(seconds: 2));

    if (isLoggedIn) {
      // Get current user
      final loggedFirebaseUser = _authRepository.loggedFirebaseUser;
      String role = await _authRepository.checkRole(loggedFirebaseUser.uid);
      print(role);
      if(role =="teacher")
        {
          emit(Authenticated(loggedFirebaseUser));
        }
      else
        {
          emit(AuthenticatedParent(loggedFirebaseUser));
        }
    } else {
      emit(Unauthenticated());
    }
  } catch (_) {
    emit(Unauthenticated());
  }
}