import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;
import 'package:file_saver/file_saver.dart';

class ScoreListExport extends StatefulWidget {
  final String classId;
  const ScoreListExport({Key? key, required this.classId}) : super(key: key);

  @override
  State<ScoreListExport> createState() => _ScoreListExportState();
}
List<List<String>> scoreList =[];
List<String> scoreListHeader =[];
class _ScoreListExportState extends State<ScoreListExport> {
  @override
  void initState() {
    print(widget.classId);
    scoreListHeader =
    ['Họ và tên', 'Môn học', 'Điểm', 'Loại điểm', 'Nhận xét', 'Thời gian'];
    scoreList.add(scoreListHeader);
    super.initState();
  }

  @override
  void dispose() {
    scoreList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
          title: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Danh sách điểm môn học', maxLines: 4,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),)
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
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
            IconButton(onPressed: () async {
              print(scoreList);
              exportCSV.myCSV([], scoreList);
            }, icon: Icon(Icons.print, color: Colors.grey, size: 22.sp,))
          ],
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('class').doc(
                widget.classId).collection('scoreList')
                .orderBy('timeCreate')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
              if (snapshot1.hasData) {
                return AnimationLimiter(
                  child: ListView.builder(
                      itemCount: snapshot1.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc = snapshot1.data!.docs[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 575),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: FutureBuilder(
                                future: FirebaseFirestore.instance.collection('class')
                                    .doc(widget.classId).collection('student').doc(
                                    doc.get('idStudent'))
                                    .get(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    scoreList.add([
                                      snapshot.data['name'],
                                      doc.get('title'),
                                      doc.get('score').toString(),
                                      doc.get('cateSelect'),
                                      doc.get('comment'),
                                      doc.get('time')]);
                                    return Column(
                                      children: [
                                        Padding(padding: EdgeInsets.all(10),
                                            child: Container(
                                              width: 100.w,
                                              height: 12.h,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1, color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.sp)),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  SizedBox(width: 10,),
                                                  CircleAvatar(radius: 25.sp,
                                                    backgroundImage: NetworkImage(
                                                        snapshot.data['avatar']),
                                                    backgroundColor: Colors.white,
                                                  ),
                                                  SizedBox(width: 2.w,),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                              maxWidth: 90.w),
                                                          child: Text(
                                                              snapshot.data['name'],
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 15.sp,
                                                                  fontWeight: FontWeight
                                                                      .bold),
                                                              textAlign: TextAlign
                                                                  .center)
                                                      ),
                                                      SizedBox(height: 1.h,),
                                                      Row(
                                                        children: [

                                                          ConstrainedBox(
                                                              constraints: BoxConstraints(
                                                                  maxWidth: 70.w),
                                                              child: Text("Môn " +
                                                                  doc.get('title') +
                                                                  ': ', maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontSize: 15.sp,
                                                                      fontWeight: FontWeight
                                                                          .bold),
                                                                  textAlign: TextAlign
                                                                      .center)
                                                          ),
                                                          ConstrainedBox(
                                                              constraints: BoxConstraints(
                                                                  maxWidth: 20.w),
                                                              child: Text(
                                                                  doc.get('score')
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontSize: 15.sp,
                                                                      fontWeight: FontWeight
                                                                          .bold),
                                                                  textAlign: TextAlign
                                                                      .center)
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 1.h,),
                                                      ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                              maxWidth: 70.w),
                                                          child: Text("Loại: " +
                                                              doc.get('cateSelect'),
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 15.sp,
                                                                  fontWeight: FontWeight
                                                                      .bold),
                                                              textAlign: TextAlign
                                                                  .center)
                                                      ),
                                                      SizedBox(height: 1.h,),
                                                      ConstrainedBox(
                                                          constraints: BoxConstraints(
                                                              maxWidth: 90.w),
                                                          child: Text("Bởi: " +
                                                              doc.get('sentBy'),
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 15.sp,
                                                                  fontWeight: FontWeight
                                                                      .bold),
                                                              textAlign: TextAlign
                                                                  .center)
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              ),
                                            )
                                        ),


                                      ],
                                    );
                                  }
                                  return Center();
                                },

                              ),
                            ),
                          ),
                        );
                      }
                  ),
                );
              }
              return Center();
            }
        )
    );
  }
}