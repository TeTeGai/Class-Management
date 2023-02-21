import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ScoreStatisticScreen extends StatefulWidget {
  final StudentModel studentModel;
  const ScoreStatisticScreen({Key? key, required this.studentModel,}) : super(key: key);

  @override
  State<ScoreStatisticScreen> createState() => _ScoreStatisticScreenState();
}

class _ScoreStatisticScreenState extends State<ScoreStatisticScreen> {


  Future getclassId()
  async {
    final prefs =  await SharedPreferences.getInstance();
    String? classId = prefs.getString('classId');
    return classId;
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
          future: getclassId(),
          builder: (context, snapshot)
          {
           return
                StreamBuilder(
                    stream:  FirebaseFirestore.instance.collection("class").doc(snapshot.data.toString()).collection("scoreList").where("idStudent",isEqualTo: widget.studentModel.id).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (!streamSnapshot.hasData) return const Center(child: CircularProgressIndicator());
                      return GroupedListView<dynamic, String>(
                        shrinkWrap: true,
                        elements: streamSnapshot.data!.docs,
                        groupBy: (element) => element['time'],
                        groupSeparatorBuilder: (String value) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value,
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                        order: GroupedListOrder.DESC,

                        itemBuilder: (context, dynamic element) {
                          return Column(
                            children: [
                              Padding(padding: EdgeInsets.all(10),
                                child:    Container(
                                  width: 100.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1,color: Colors.grey),
                                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 10,),
                                      CircleAvatar(radius: 25.sp,
                                        backgroundImage: AssetImage(element['img']),
                                        backgroundColor: Colors.white,
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(maxWidth: 70.w),
                                                  child: Text("Môn "+element['title']+": ", maxLines: 2,
                                                      style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                                              ),
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(maxWidth: 20.w),
                                                  child: Text(element['score'].toString(), maxLines: 2,
                                                      style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                                              ),
                                            ],
                                          ),
                                          ConstrainedBox(
                                              constraints: BoxConstraints(maxWidth: 90.w),
                                              child: Text("Bởi: "+element['sentBy'], maxLines: 2,
                                                  style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                )
                              ),


                            ],
                          );
                        },
                      );
                    }
                );
           }
    );



  }
}

