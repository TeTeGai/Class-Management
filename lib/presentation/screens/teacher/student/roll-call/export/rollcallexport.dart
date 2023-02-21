
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;

class RollCallExport extends StatefulWidget {
  final String classId;
  const RollCallExport({Key? key, required this.classId}) : super(key: key);

  @override
  State<RollCallExport> createState() => _RollCallExportState();
}
List<Text> text = [
  Text("Đi học",style: TextStyle(fontSize: 15.sp,color: Colors.blue),),
  Text("Đi muộn",style: TextStyle(fontSize: 15.sp,color: Colors.yellow.shade700),),
  Text("Nghỉ không phép",style: TextStyle(fontSize: 15.sp,color: Colors.red),),
  Text("Nghỉ có phép",style: TextStyle(fontSize: 15.sp,color: Colors.grey),)
];
List<List<String>> rollCallList =[];
List<String> rollCallHeader =[];
class _RollCallExportState extends State<RollCallExport> {
  @override
  void initState() {
    print(widget.classId);
    rollCallHeader=['Họ và tên','Đi học','Muộn','Nghỉ có phép','Nghỉ không phép','Thời gian'];
    rollCallList.add(rollCallHeader);
    super.initState();
  }
  @override
  void dispose() {
    rollCallList.clear();
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
        title:  ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text('Danh sách điểm rèn luyện',  maxLines: 4,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
            print(rollCallList);
            exportCSV.myCSV([], rollCallList );
            // gpaList.clear();
          },icon: Icon(Icons.print,color: Colors.grey,size:  22.sp,))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('class').doc(widget.classId).collection('rollCall').orderBy('time').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return  ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                if(doc.get('rollCall') == 0)
                  {
                    rollCallList.add([
                      doc.get('name'),
                      "1",
                      "",
                      "",
                      '',
                      doc.get('time')]);
                  }
                else if(doc.get('rollCall') == 1)
                {
                  rollCallList.add([
                    doc.get('name'),
                    "",
                    "1",
                    "",
                    '',
                    doc.get('time')]);
                }
                else if(doc.get('rollCall') == 2)
                {
                  rollCallList.add([
                    doc.get('name'),
                    "",
                    "",
                    "1",
                    '',
                    doc.get('time')]);
                }
                else if(doc.get('rollCall') == 3)
                {
                  rollCallList.add([
                    doc.get('name'),
                    "",
                    "",
                    "",
                    '1',
                    doc.get('time')]);
                }

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
                                          SizedBox(width: 2.w,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(maxWidth: 90.w),
                                                  child: Text(  doc.get('name'), maxLines: 2,
                                                      style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                                              ),
                                              SizedBox(height: 1.h,),
                                              Row(
                                                children: [
                                                  ConstrainedBox(
                                                      constraints: BoxConstraints(maxWidth: 70.w),
                                                      child: text[doc.get('rollCall')],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 1.h,),
                                              ConstrainedBox(
                                                  constraints: BoxConstraints(maxWidth: 90.w),
                                                  child: Text(  doc.get('time'), maxLines: 2,
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
                          }

                    );


          }
          else  if (!snapshot.hasData)
            {
              return Center();
            }
          return Center();

        },
      ),
    );
  }
}
