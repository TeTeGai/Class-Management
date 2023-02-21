

import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/repository/class_repository/firebase_class_repo.dart';
import 'package:luan_an/data/repository/student_repository/firebase_student_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../utils/validator.dart';
import 'bloc.dart';



class EditStudentBloc extends Bloc<EditClassEvent,EditStudentState>
{
  EditStudentBloc():super(EditStudentState.emty())
  {
    on<SchoolChange>((event, emit) async => await _mapSchoolChangeToState(emit,event,event.school));
    on<Submit>((event, emit) async {
      await _mapFormSubmitToState(
          emit,
          event,
      );
    });
    on<ParentSubmit>((event, emit) async {
      await _mapParentSubmitToState(
        emit,
        event,
      );
    });
  }

  Future<void> _mapSchoolChangeToState(Emitter emit, SchoolChange event, String school)
  async {
    var schoolValid = UtilValidators.isNotEmpty(school);
    emit(state.update(isNameVaild: schoolValid));
  }

  Future<void> _mapFormSubmitToState(
      Emitter emit, Submit event,
      )
  async {
    FirebaseStudentRepository _firebaseStudentRepository = FirebaseStudentRepository();
    final prefs = await SharedPreferences.getInstance();
    final String? classId = prefs.getString('classId');
    try
    {
      emit(EditStudentState.creating());
      await _firebaseStudentRepository.editStudent(event.studentModel,event.file,event.img,classId!);
      if(true)
      {
        EditStudentState.success();
      }
      else{
        EditStudentState.fail("loi");
      }
    } catch (e)
    {
      EditStudentState.fail(e.toString());
    }

  }

  Future<void> _mapParentSubmitToState(
      Emitter emit, ParentSubmit event,
      )
  async {
    FirebaseStudentRepository _firebaseStudentRepository = FirebaseStudentRepository();
    try
    {
      emit(EditStudentState.creating());
      await _firebaseStudentRepository.editSon(event.studentModel,event.file,event.img);
      if(true)
      {
        EditStudentState.success();
      }
      else{
        EditStudentState.fail("loi");
      }
    } catch (e)
    {
      EditStudentState.fail(e.toString());
    }

  }
}