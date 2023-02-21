import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/profile/bloc.dart';

import 'addnews_form.dart';
import 'bloc/addnews_bloc.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddNewsBloc()),
        BlocProvider(create: (context) => ProfileBloc()..add(LoadProfile())),
      ],
      
        child: AddNewsForm()

 
    );
  }
}
