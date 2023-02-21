import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/addsons/bloc/addsons_bloc.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/addsons/widget/addsons_form.dart';
import 'package:luan_an/presentation/screens/teacher/classselect/addclass/widget/addclass_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddSonsScreen extends StatelessWidget {
  const AddSonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AddSonsBloc(),
      child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
              title:  ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Text('Thêm con',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    size: 24,
                  ),
                  padding: EdgeInsets.only(left: 0),
                  shape: CircleBorder(),
                ),
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: AddSonForm()
      ),
    );
  }
}

