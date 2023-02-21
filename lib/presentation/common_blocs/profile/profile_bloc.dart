
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repository/repository.dart';
import 'bloc.dart';

StreamSubscription? _profileStreamSub;
AuthRepository _authRepository = AppRepository.authRepository;
UserAuthRepository _userRepository = AppRepository.userRepository;
UserModel? _loggedUser;
class ProfileBloc extends Bloc<ProfileEvent,ProfileState>
{

  ProfileBloc() : super(LoadingProfile())
  {
    on<LoadProfile>((event, emit) async => await _mapLoadProfileToState(emit,event));
    // on<UploadAvatar>((event, emit) async => await );
    on<UpdateProfile>((event, emit) async => await _mapProfileUpdateToState(emit, event));
    on<LoadProfileById>((event, emit) async => await _mapLoadProfileByIdToState(emit,event));
    on<UpdateProfileById>((event, emit) async => await _mapProfileUpdateByIdToState(emit, event));

  }

  Future<void> _mapLoadProfileToState(Emitter<ProfileState> emit,LoadProfile loadProfile,) async
  {
    try
    {
      _profileStreamSub?.cancel();
      _profileStreamSub = _userRepository.loggedUserStream(
          _authRepository.loggedFirebaseUser)
          .listen((event) => add(UpdateProfile(event)));
    } catch(e) {
      emit(LoadFailProfile(e.toString()));
    }
  }

  Future<void> _mapProfileUpdateToState(Emitter<ProfileState> emit,UpdateProfile event)
  async {
    try{
      _loggedUser = event.userModel;
      emit(LoadedProfile(event.userModel));
    }
    catch (e)
    {
      emit(LoadFailProfile(e.toString()));
    }
  }

  Future<void> _mapLoadProfileByIdToState(Emitter<ProfileState> emit,LoadProfileById loadProfile,) async
  {
    try
    {
      _userRepository.getUserByID(loadProfile.userId).then((value) {
        return add(UpdateProfileById(value));
      });
    } catch(e) {
      emit(LoadFailProfile(e.toString()));
    }
  }

  Future<void> _mapProfileUpdateByIdToState(Emitter<ProfileState> emit,UpdateProfileById event)
  async {
    try{
      emit(LoadedProfileById(event.userModel));
    }
    catch (e)
    {
      emit(LoadFailProfile(e.toString()));
    }
  }
  @override
  Future<void> close() {
    _profileStreamSub?.cancel();
    // TODO: implement close
    return super.close();
  }
}
