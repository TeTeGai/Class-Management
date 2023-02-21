import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gpason_chart_screen.dart';


class GpaSonHomeStatisticScreen extends StatefulWidget {
  final StudentModel studentModel;
  const GpaSonHomeStatisticScreen({Key? key, required this.studentModel,}) : super(key: key);

  @override
  State<GpaSonHomeStatisticScreen> createState() => _GpaSonHomeStatisticScreenState();
}

class _GpaSonHomeStatisticScreenState extends State<GpaSonHomeStatisticScreen> with AutomaticKeepAliveClientMixin<GpaSonHomeStatisticScreen>{



  @override
  Widget build(BuildContext context) {
            return SingleChildScrollView(
              child:  Column(
                          children: [
                            GpaSonHomeChartScreen(studentModel: widget.studentModel),
                            StreamBuilder(
                                      stream:  FirebaseFirestore.instance.collection("class").doc(widget.studentModel.classId).collection("gpaHomeList").where("idStudent",isEqualTo: widget.studentModel.idStudent).snapshots(),
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
                                                    child:   Container(
                                                      width: 100.w,
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  CircleAvatar(radius: 22.sp, backgroundImage: AssetImage(element['img']),backgroundColor: Colors.white,),

                                                                  SizedBox(height: 0.6.h,),
                                                                  if(element['score'] >0)
                                                                    ...  [
                                                                      Positioned(
                                                                          right: 0,
                                                                          top: 0,
                                                                          child: Container(
                                                                            padding: EdgeInsets.all(2.5),
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                  width: 2,
                                                                                  color: Colors.white
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(100.0),
                                                                              color: Colors.blue,
                                                                            ),
                                                                            child: Text(element['score'].toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                                          )
                                                                      )
                                                                    ]
                                                                  else if(element['score'] <0)
                                                                    ...  [
                                                                      Positioned(
                                                                          right: 0,
                                                                          top: 0,
                                                                          child: Container(
                                                                            padding: EdgeInsets.all(2.5),
                                                                            decoration: BoxDecoration(
                                                                              border: Border.all(
                                                                                  width: 2,
                                                                                  color: Colors.white
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(100.0),
                                                                              color: Colors.red,
                                                                            ),
                                                                            child: Text(element['score'].toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                                          )
                                                                      )
                                                                    ]

                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(width: 5.w,),
                                                          Column(
                                                            children: [
                                                              SizedBox(
                                                                width: 63.w,
                                                                child: Text(element['title'],maxLines: 2,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                                              ),
                                                              SizedBox(
                                                                width: 63.w,
                                                                child: Text("Bởi: "+element['sentBy'],maxLines: 2,style: TextStyle(fontSize: 14.sp),),
                                                              ),
                                                            ],
                                                          ),
                                                          IconButton(
                                                              onPressed: (){},
                                                              icon: Icon(Icons.more_horiz))
                                                        ],
                                                      ),
                                                    ),
                                                  ),


                                                ],
                                              );
                                            },
                                          );
                                        }
                            ),
                          ],
                        )
            );




  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

