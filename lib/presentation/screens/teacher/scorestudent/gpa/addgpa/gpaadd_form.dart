import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/gpa_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../utils/snackbar.dart';


class GpaAddForm extends StatefulWidget {
  final String GoodOrBad;
  const GpaAddForm({Key? key, required this.GoodOrBad}) : super(key: key);

  @override
  State<GpaAddForm> createState() => _GpaAddFormState();
}

class _GpaAddFormState extends State<GpaAddForm> {
  late ScoreBloc scoreBloc;
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
  void initState() {
    scoreBloc = BlocProvider.of<ScoreBloc>(context);
    super.initState();
  }
  @override
  void dispose() {
    scoreBloc.close();
    // TODO: implement dispose
    super.dispose();
  }
  void onPress()
  {
    GPAModel gpa;

    if(scoreEditingController.text.trim().isNotEmpty && nameEditingController.text.trim().isNotEmpty)
    {
      int scoreGpaGood =int.parse(scoreEditingController.text);
      int scoreGpaBad =int.parse( "-"+scoreEditingController.text);
      if(widget.GoodOrBad == "Good")
      {
        gpa = GPAModel(title: nameEditingController.text,
            score: scoreGpaGood,avatar: img, category: "GoodGPA", id: '',timeCreate: Timestamp.now());
        gpaModel = gpa.cloneWith();
        try{
          scoreBloc.add(GpaAdd(gpaModel));
          Navigator.of(context).pop();
          MySnackBar.error(message: "Đã thêm điểm tích cực", color: Colors.cyan, context: context,);
        }catch(e)
        {
          MySnackBar.error(message: "Có lỗi đã xảy ra vui lòng thử lại", color: Colors.red, context: context,);

        }

      }
      else if (widget.GoodOrBad == "Bad")
      {
        gpa = GPAModel(title: nameEditingController.text,
            score: scoreGpaBad,avatar: img, category: "BadGPA", id: '',timeCreate: Timestamp.now());
        gpaModel = gpa.cloneWith();
        try{
          scoreBloc.add(GpaAdd(gpaModel));
          Navigator.of(context).pop();
          MySnackBar.error(message: "Đã điểm cần cải thiện", color: Colors.cyan, context: context,);
        }catch(e)
        {
          MySnackBar.error(message: "Có lỗi đã xảy ra vui lòng thử lại", color: Colors.red, context: context,);
        }
      }
    }
    else {
      MySnackBar.error(message: "Chưa đủ thông tin", color: Colors.red, context: context,);
    }

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc,ScoreState>(
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
            Container(
              width: 85.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black54),
                    top: BorderSide(color: Colors.black54),
                    left: BorderSide(color: Colors.black54),
                    right: BorderSide(color: Colors.black54),
                  )
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: () {
                  onPress();
                },
                color: Colors.cyan,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("Thêm điểm rèn luyện", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white
                ),),
              ),
            )
          ],
        );
      },
    );
  }
  Widget nameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: nameEditingController,
          decoration: InputDecoration(
            labelText: "Tiêu đề" + " (*)",
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
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: "Số điểm" + " (*)",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }


}
