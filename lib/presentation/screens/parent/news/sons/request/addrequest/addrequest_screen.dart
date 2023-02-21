import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/data/model/gpa_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../../utils/snackbar.dart';


class AddRequestScreen extends StatefulWidget {
  final StudentModel studentModel;
  final String name;
  const AddRequestScreen({Key? key, required this.studentModel, required this.name}) : super(key: key);

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();
  String img = "assets/questions.png";
  List<String> productGood = ["assets/backpack.png","assets/student.png",
    "assets/learning.png","assets/art.png","assets/book.png",
    "assets/flower.png","assets/idea.png","assets/check-list.png",
    "assets/real-estate.png","assets/finance.png","assets/calendar.png",
    "assets/workout.png","assets/bomb.png","assets/thief.png",
    "assets/apple-fruit.png","assets/protest.png","assets/zzz.png",
    "assets/knife.png","assets/question.png","assets/watch.png",
    "assets/sword.png","assets/student-1.png","assets/mental-health.png",
    "assets/lips.png"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
        title:  ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text('Yêu cầu',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
        actions: [
          IconButton(onPressed: (){
            StudentBloc()..add(AddRequest(
                titleEditingController.text,
                contentEditingController.text,
                img,
                widget.studentModel.classId!,
                widget.studentModel.idStudent!,
                widget.name
            ));
            Navigator.of(context).pop();
            MySnackBar.error(message: "Đã gửi yêu cầu tới các giáo viên" , color: Colors.cyan, context: context);

          }, icon: Icon(Icons.check))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<StudentBloc,StudentState>(
        bloc: StudentBloc(),
        builder: (context, state) {
          return  Column(
            children: [
              Center(
                    child: GestureDetector(
                      onTap: ()
                      {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 40.h,
                              color: Colors.grey.shade200,
                              child: GridView.builder(
                                itemCount:productGood.length ,
                                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                ),
                                key: UniqueKey(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return   Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: InkWell(
                                      onTap: () async {
                                        Navigator.pop(context);
                                        setState(() {
                                          img = productGood[index];
                                        });
                                      },
                                      child: Container(
                                        height: 8.h,
                                        width: 8.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(productGood[index]),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  );
                                },

                              ),

                            );
                          },
                        );
                      },
                      child: CircleAvatar(radius: 35.sp,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(img),
                      ),
                    ),
                  ),

              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: titleInput(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: contentInput(),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget titleInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: titleEditingController,
          decoration: InputDecoration(
            labelText: "Tiêu đề" + "*",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }


  Widget contentInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: contentEditingController,
          decoration: InputDecoration(
            labelText: "Nội dung" + "*",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }


}
