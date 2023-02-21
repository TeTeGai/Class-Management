import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/utils/loading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../bloc/bloc.dart';
import 'claswidget.dart';

class ClassSelectForm extends StatefulWidget {
  const ClassSelectForm({Key? key}) : super(key: key);

  @override
  State<ClassSelectForm> createState() => _ClassSelectFormState();
}


class _ClassSelectFormState extends State<ClassSelectForm> {

  @override
  void initState() {
    BlocProvider.of<ClassSelectBloc>(context).add(ClassLoad());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <ClassSelectBloc,ClassSelectSate>(
      builder: (context, state) {
        if (state is ClassLoading)
          {
            Loading();
          }
        if(state is ClassLoaded)
          {
            var classModel = state.classModel;
            return classModel.length>0 ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: classModel.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(child: Column(
                  children: [
                    ClassWidget(classModel: classModel[index]),
                  ],
                ));
              },
            ) :Center();
          }
        if(state is ClassLoadFail) {}
        return Center();
      },

    );
  }
}
