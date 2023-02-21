import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/data/model/gpa_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class GpaSonAddForm extends StatefulWidget {
  final String GoodOrBad;
  const GpaSonAddForm({Key? key, required this.GoodOrBad}) : super(key: key);

  @override
  State<GpaSonAddForm> createState() => _GpaSonAddFormState();
}

class _GpaSonAddFormState extends State<GpaSonAddForm> {
  late GPAModel gpaModel;
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController scoreEditingController = TextEditingController();
  String img = "assets/questions.png";
  List<String> productGood = ["assets/backpack.png","assets/student.png",
    "assets/learning.png","assets/art.png","assets/book.png",
    "assets/flower.png","assets/idea.png","assets/check-list.png",
    "assets/real-estate.png","assets/finance.png","assets/calendar.png",
    "assets/workout.png"
  ];
  List<String> productBad= ["assets/bomb.png","assets/thief.png",
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
            child: Text('Thêm điểm rèn luyện',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
      body: BlocBuilder<ScoreBloc,ScoreState>(
        bloc: ScoreBloc(),
        builder: (context, state) {
          return  Column(
            children: [
              if(widget.GoodOrBad =="Good")
                ...[
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
                                  crossAxisCount: 4,
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
                ]
              else if(widget.GoodOrBad =="Bad")
                ...[
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
                                itemCount:productBad.length ,
                                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
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
                                        setState(() {
                                          Navigator.pop(context);
                                          img = productBad[index];
                                        });
                                      },
                                      child: Container(
                                        height: 8.h,
                                        width: 8.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage(productBad[index]),
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
                ]
              ,

              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: nameInput(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: scoreInput(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  onPressed: () {
                    GPAModel gpa;
                    int scoreGpa =int.parse(scoreEditingController.text);
                    if(widget.GoodOrBad == "Good")
                      {
                        gpa = GPAModel(title: nameEditingController.text,
                            score: scoreGpa,avatar: img, category: "GoodGPA", id: '',timeCreate: Timestamp.now());
                        gpaModel = gpa.cloneWith();
                        ScoreBloc().add(GpaSonAdd(gpaModel));
                      }
                    else if (widget.GoodOrBad == "Bad")
                      {
                        gpa = GPAModel(title: nameEditingController.text,
                            score: scoreGpa,avatar: img, category: "BadGPA", id: '',timeCreate: Timestamp.now());
                        gpaModel = gpa.cloneWith();
                        ScoreBloc().add(GpaSonAdd(gpaModel));
                      }

                  },
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Đăng ký", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget nameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: nameEditingController,
          decoration: InputDecoration(
            labelText: "Tiêu đề" + "*",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }


  Widget scoreInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.number,
          controller: scoreEditingController,
          decoration: InputDecoration(
            labelText: "Số điểm" + "*",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }


}
