

import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/repository/class_repository/firebase_class_repo.dart';

import '../../../../../../utils/validator.dart';
import 'bloc.dart';



class EditClassBloc extends Bloc<EditClassEvent,EditClassState>
{
  EditClassBloc():super(EditClassState.emty())
  {
    on<SchoolChange>((event, emit) async => await _mapSchoolChangeToState(emit,event,event.school));
    on<GradeChange>((event, emit) async => await _mapGradeChangeToState(emit,event,event.grade));
    on<ClassChange>((event, emit) async => await _mapClassChangetoSate(emit,event,event.clas));
    on<Submit>((event, emit) async {
      await _mapFormSubmitToState(
          emit,
          event,
      );
    });
  }

  Future<void> _mapSchoolChangeToState(Emitter emit, SchoolChange event, String school)
  async {
    var schoolValid = UtilValidators.isNotEmpty(school);
    emit(state.update(isSchoolVaild: schoolValid));
  }
  Future<void> _mapGradeChangeToState(Emitter emit, GradeChange event, String grade)
  async {
    var gradeValid = UtilValidators.isNotEmpty(grade);
    emit(state.update(isGradeVaild: gradeValid));
  }
  Future<void> _mapClassChangetoSate(Emitter emit, ClassChange event, String clas)
  async {
    var clasValid = UtilValidators.isNotEmpty(clas);
    emit(state.update(isClasVaild: clasValid));
  }

  Future<void> _mapFormSubmitToState(
      Emitter emit, Submit event,
      )
  async {
    FirebaseClassRepository _firebaseClassRepository = FirebaseClassRepository();
    try
    {
      emit(EditClassState.creating());
      await _firebaseClassRepository.editClass(event.classModel,event.file,event.img);
      if(true)
      {
        EditClassState.success();
      }
      else{
        EditClassState.fail("loi");
      }
    } catch (e)
    {
      EditClassState.fail(e.toString());
    }

  }
}