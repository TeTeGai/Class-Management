

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/repository/class_repository/firebase_class_repo.dart';
import 'package:luan_an/data/repository/student_repository/firebase_student_repo.dart';

import '../../../../../../../data/repository/chat_repository/firebase_chat_repo.dart';
import '../../../../../../../utils/snackbar.dart';
import '../../../../../../../utils/validator.dart';
import 'bloc.dart';



class ConnectSonBloc extends Bloc<ConnectSonEvent,ConnectSonState>
{
  FirebaseChatRepository firebaseChatRepository = new FirebaseChatRepository();
  FirebaseClassRepository firebaseClassRepository = new FirebaseClassRepository();
  FirebaseStudentRepository firebaseStudentRepository = new FirebaseStudentRepository();
  List listUserInClass =[];
  ConnectSonBloc():super(ConnectSonState.emty())
  {
    on<ClassIdChange>((event, emit) async => await _mapSchoolChangeToState(emit,event));
    on<Submit>((event, emit) async {
      await _mapFormSubmitToState(
          emit,
          event,
          );
    });
  }

  Future<void> _mapSchoolChangeToState(Emitter emit, ClassIdChange event)
  async {
    var classIdValid = UtilValidators.isNotEmpty(event.classId);
    emit(state.update(isIdVaild: classIdValid));
  }

  Future<void> _mapFormSubmitToState(
      Emitter emit, Submit event,)
  async {
    emit(ConnectSonState.joining("Đang kiểm tra"));
    if(event.classId.length < 14)
      {
        MySnackBar.error(message: "Không tồn tại lớp", color: Colors.red, context: event.context);
      }
    else
      {
        String classId = event.classId.substring(0,7);
        String studentId = event.classId.substring(7,14);
        try{
          await firebaseClassRepository.joinClass(classId, FirebaseAuth.instance.currentUser!.uid);
          await firebaseStudentRepository.AddParentStudent(FirebaseAuth.instance.currentUser!.uid, classId, studentId);
          await firebaseStudentRepository.ConnectSonToClass(FirebaseAuth.instance.currentUser!.uid, event.sonId, studentId,classId);
          print("Bạn đã tham gia vào lớp");
          ConnectSonState.success("Đã tham gia vào lớp");
          Navigator.of(event.context).pop();
          Navigator.of(event.context).pop();
          MySnackBar.error(message: "Đã kết nối với lớp", color: Colors.cyan, context: event.context);

        }catch (e)
        {
          print("Khong ton tai lop");
          ConnectSonState.fail("Không tồn tại lớp");
          MySnackBar.error(message: "Không tồn tại lớp", color: Colors.red, context: event.context);
        }
      }



  }
}