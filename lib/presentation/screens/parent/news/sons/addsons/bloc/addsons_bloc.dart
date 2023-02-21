
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/repository/student_repository/firebase_student_repo.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/addsons/bloc/addsons_event.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/addsons/bloc/bloc.dart';

class AddSonsBloc extends Bloc<AddSonsEvent,AddSonState>
{
  FirebaseStudentRepository _firebaseStudentRepository = FirebaseStudentRepository();
  AddSonsBloc():super(AddingSon()) {
    on<AddSons>((event, emit) async =>await _mapAddSonsToState(emit,event));
    }

    Future<void> _mapAddSonsToState(Emitter emit, AddSons event)
    async {

      try
      {
        await _firebaseStudentRepository.AddSons(event.studentModel,FirebaseAuth.instance.currentUser!.uid,event.file,event.img);
      } catch (e)
      {

      }
      }

    }