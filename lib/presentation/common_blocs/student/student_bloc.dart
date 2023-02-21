import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/data/repository/chat_repository/firebase_chat_repo.dart';
import 'package:luan_an/data/repository/student_repository/firebase_student_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repository/auth_repository/firebase_auth_repo.dart';
import '../../../data/repository/notification_repository/firebase_notifi_repo.dart';
import '../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../utils/pushnotifications.dart';
import 'bloc.dart';


class StudentBloc extends Bloc<StudentEvent,StudentState>
{
  FirebaseChatRepository firebaseChatRepository = new FirebaseChatRepository();

  List listUserInClass =[];
  List<UserModel> listUser=[];
  List listClass=[];
  String nameClass ='';
  String avatar ='';
  String userAvatar ='';
  FirebasaeAuthRepository firebaseAuth = new FirebasaeAuthRepository();
  FirebaseStudentRepository studentRepository = FirebaseStudentRepository();
  FirebaseNotificationRepository firebaseNotificationRepository = new FirebaseNotificationRepository();
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  var user = FirebaseAuth.instance.currentUser!.uid;
  StreamSubscription? _studentStreamSub;
  StudentBloc(): super(LoadingStudent())
  {
    on<AddStudent>((event, emit) async=> await _mapAddStudentToState(emit,event));
    on<LoadStudent>((event, emit) async=> await _mapLoadStudentToState(emit, event));
    on<UpdateStudent>((event, emit) async=> await _mapUpdateStudentToState(emit, event));
    on<UpdateStudentParent>((event, emit) async=> await _mapUpdateStudentParentToState(emit, event));
    on<UpdateStudentNoParent>((event, emit) async=> await _mapUpdateStudentNoParentToState(emit, event));
    on<LoadStudentParent>((event, emit) async=> await _mapLoadStudentAndParentsToState(emit, event));
    on<LoadStudentNoParent>((event, emit) async=> await _mapLoadStudentNoParentsToState(emit, event));
    on<LoadTeacherUser>((event, emit) async=> await _mapLoadTeacherUserToState(emit, event));
    on<UpdateTeacherUser>((event, emit) async=> await _mapUserTeacherUpdateToState(emit, event));
    on<LoadSons>((event, emit) async=> await _mapLoadSonsToState(emit, event));
    on<UpdateSons>((event, emit) async=> await _mapUpdateSonsToState(emit, event));
    on<AddRequest>((event, emit) async=> await _mapAddRequestToState(emit,event));
    on<LoadRequest>((event, emit) async=> await _mapLoadRequestToState(emit,event));
    on<LoadClassRequest>((event, emit) async=> await _mapLoadClassRequestToState(emit,event));
    on<UpdateRequest>((event, emit) async=> await _mapUpdateRequestToState(emit,event));
    on<RemoveStudent>((event, emit) async=> await _mapRemoveStudentToState(emit,event));
    on<RemoveSon>((event, emit) async=> await _mapRemoveSonToState(emit,event));
    on<AddRollCall>((event, emit) async=> await _mapAddRollCallToState(emit,event));
    on<RemoveRequest>((event, emit) async=> await _mapRemoveRequestToState(emit,event));
    on<UpdateModelRequest>((event, emit) async=> await _mapUpdateModelRequestToState(emit,event));
  }
  Future<void> _mapAddStudentToState(Emitter emit, AddStudent event, )
  async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      await studentRepository.AddStudent(event.name, classId!);
    }catch (e)
    {
      e.toString();
    }
  }

  Future<void> _mapAddRollCallToState(Emitter emit, AddRollCall event, )
  async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');

      await studentRepository.AddRollCall( classId!,event.name,event.rollCall,event.time);

    }catch (e)
    {
      e.toString();
    }
  }

  Future<void> _mapAddRequestToState(Emitter emit, AddRequest event, )
  async {
    try{

      await firebaseChatRepository.loadUserInClass(event.classId).then((value) {
        listUserInClass.addAll(value);
      });
      await firebaseChatRepository.loadAvatarClass(event.classId).then((value) {
        avatar = value;
      });
      await userAuthRepository.getUserByID(FirebaseAuth.instance.currentUser!.uid).then((value) {
        userAvatar = value.avatar;
      });
      await firebaseNotificationRepository.AddNotifiCationToClass(
        "Phhs em: "+ event.name + " đã thêm 1 yêu cầu",
        event.classId,
        userAvatar,
        false,
      );
      listUserInClass.forEach((element) async {
        if (element != FirebaseAuth.instance.currentUser!.uid) {
          String role = await firebaseAuth.checkRole(element);
          if(role =="teacher")
          {
            userAuthRepository.getUserByID(element).then((value) {
              PushNotifications.callOnFcmApiSendPushNotifications(
                  body:  "Phhs em: "+ event.name + " đã thêm 1 yêu cầu mới tới lớp",
                  To: value.pushToken!);
            });
          }
        }
      });
      await studentRepository.AddRequest(event.title, event.content, event.img, event.classId, event.studentId);
    }catch (e)
    {
      e.toString();
    }
  }

  Future<void> _mapRemoveRequestToState(Emitter emit, RemoveRequest event, )
  async {
    try{
      await studentRepository.RemoveRequest(event.classId, event.requestId);
    }catch (e)
    {
      e.toString();
    }
  }

  Future<void> _mapUpdateModelRequestToState(Emitter emit, UpdateModelRequest event, )
  async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      await studentRepository.UpdateRequest(classId!,event.requestId);
      await firebaseChatRepository.loadNameClass(classId!).then((value) {
        nameClass = value;
      });
      await firebaseChatRepository.loadAvatarClass(classId!).then((value) {
        avatar = value;
      });
      if(event.idParent != null)
      {
        await firebaseNotificationRepository.AddNotifiCation(
          event.idParent,
          event.title + " đã xác nhận yêu cầu của bạn",
          avatar,
          nameClass,
          false,
        );
      }
    }catch (e)
    {
      e.toString();
    }
  }
  Future<void> _mapRemoveStudentToState(Emitter emit, RemoveStudent event, )
  async {
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      await studentRepository.RemoveStudent(event.idStudent, classId!);
    }catch (e)
    {
      e.toString();
    }
  }
  Future<void> _mapRemoveSonToState(Emitter emit, RemoveSon event, )
  async {
    try{
      await studentRepository.RemoveSon(event.idSon);
    }catch (e)
    {
      e.toString();
    }
  }
  Future<void> _mapLoadStudentToState(Emitter<StudentState> emit,LoadStudent event)
  async {
    emit(LoadingStudent());
    try{
      _studentStreamSub?.cancel();
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      _studentStreamSub = studentRepository.LoadStudent(classId!).listen((event) => add(UpdateStudent(event)));
    }catch(e)
    {
    }
  }

  Future<void> _mapLoadSonsToState(Emitter<StudentState> emit,LoadSons event)
  async {
    emit(LoadingStudent());
    try{
      _studentStreamSub?.cancel();
      _studentStreamSub = studentRepository.LoadSons(FirebaseAuth.instance.currentUser!.uid).listen((event) => add(UpdateSons(event)));
    }catch(e)
    {
    }
  }

  Future<void> _mapUpdateSonsToState(Emitter emit,UpdateSons event)
  async {
    try{
      emit(LoadedSons(event.studentModel));
    }
    catch (e)
    {
      emit(LoadFailStudent(e.toString()));
    }
  }


  Future<void> _mapLoadStudentAndParentsToState(Emitter emit,LoadStudentParent event)
  async {
    emit(LoadingStudent());
    try{
      _studentStreamSub?.cancel();
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      _studentStreamSub = studentRepository.LoadStudentParent(classId!).listen((event) => add(UpdateStudentParent(event)));

    }catch(e)
    {

    }
  }
  Future<void> _mapUpdateStudentParentToState(Emitter emit,UpdateStudentParent event)
  async {
    try{

      emit(LoadedStudentParent(event.studentModel,));
    }
    catch (e)
    {
      emit(LoadFailStudent(e.toString()));
    }
  }

  Future<void> _mapLoadStudentNoParentsToState(Emitter emit,LoadStudentNoParent event)
  async {
    emit(LoadingStudent());
    try{
      _studentStreamSub?.cancel();
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      _studentStreamSub = studentRepository.LoadStudentNoParent(classId!).listen((event) => add(UpdateStudentNoParent(event)));

    }catch(e)
    {

    }
  }
  Future<void> _mapUpdateStudentNoParentToState(Emitter emit,UpdateStudentNoParent event)
  async {
    try{
      emit(LoadedStudentNoParent(event.studentModel));
    }
    catch (e)
    {
      emit(LoadFailStudent(e.toString()));
    }
  }
  Future<void> _mapUpdateStudentToState(Emitter emit,UpdateStudent event)
  async {
    try{
      emit(LoadedStudent(event.studentModel));
    }
    catch (e)
    {
      emit(LoadFailStudent(e.toString()));
    }
  }



  Future<void> _mapLoadTeacherUserToState(Emitter emit, LoadTeacherUser event)
  async{
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    await  firebaseChatRepository.loadUserInClass(classId!).then((value) {
      listUserInClass.addAll(value);
    }) ;

    print(listUserInClass);
    listUserInClass.forEach((element)  async {
      _studentStreamSub =
          firebaseChatRepository.LoadTeacherUser(element).listen((event) {
            listUser.addAll(event);
            add(UpdateTeacherUser(listUser.toList()));
          }
          );
    }
    );
  }

  Future<void> _mapUserTeacherUpdateToState( Emitter emit,  UpdateTeacherUser event)
  async{
    emit(LoadedTeacherUser(event.usermodel));
  }

  Future<void> _mapLoadRequestToState(Emitter<StudentState> emit,LoadRequest event)
  async {
    emit(LoadingStudent());
    try{
      _studentStreamSub?.cancel();
      _studentStreamSub = studentRepository.LoadRequest(event.classId!,event.studentId).listen((event) => add(UpdateRequest(event)));
    }catch(e)
    {
    }
  }

  Future<void> _mapLoadClassRequestToState(Emitter<StudentState> emit,LoadClassRequest event)
  async {
    emit(LoadingStudent());
    try{
      final prefs = await SharedPreferences.getInstance();
      final String? classId = prefs.getString('classId');
      _studentStreamSub?.cancel();
      _studentStreamSub = studentRepository.LoadRequest(classId!,event.studentId).listen((event) => add(UpdateRequest(event)));
    }catch(e)
    {
    }
  }

  Future<void> _mapUpdateRequestToState( Emitter emit,  UpdateRequest event)
  async{
    emit(LoadedRequest(event.requestModel));
  }

  @override
  Future<void> close() {
    _studentStreamSub?.cancel();
    listUserInClass.clear();
    listUser.clear();
    return super.close();
  }
}