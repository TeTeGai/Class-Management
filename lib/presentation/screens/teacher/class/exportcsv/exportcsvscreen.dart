import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/presentation/screens/teacher/class/exportcsv/widget/scorelistexport.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/snackbar.dart';
class ExportCsvScreen extends StatefulWidget {
  const ExportCsvScreen({Key? key}) : super(key: key);

  @override
  State<ExportCsvScreen> createState() => _ExportCsvScreenState();
}
class _ExportCsvScreenState extends State<ExportCsvScreen> {
  Future getclassId()
  async {
    final prefs =  await SharedPreferences.getInstance();
    String? classId = prefs.getString('classId');
    return classId;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getclassId(),
      builder:(context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            title: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Text("Xuất file excel", maxLines: 4,
                  style: TextStyle(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),)
            ),
            centerTitle: true,
            leading: Padding(
              padding: const
              EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context,).pop();
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
          body: Column(
            children: [

              Image.asset(
                "assets/excel.jpeg",
                fit: BoxFit.cover,
                height: 50.h,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Colors.blueGrey,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(AppRouter.SCORELISTEXPORT,arguments: snapshot.data.toString());
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: <Widget>[
                                    Icon(
                                      Icons.score, color: Colors.white,
                                      size: 25.sp,),
                                    SizedBox(height: 1.h),
                                    Center(
                                      child: Text("Danh sách điểm",
                                        style: TextStyle(fontSize: 17.sp,
                                            color: Colors.white),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),


                          Expanded(
                            child: Container(
                              color: Colors.indigo,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(AppRouter.GPALISTEXPORT,arguments: snapshot.data.toString());
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: <Widget>[
                                    Icon(
                                      Icons.scoreboard, color: Colors.white,
                                      size: 25.sp,),
                                    SizedBox(height: 1.h),
                                    Center(
                                      child: Text("Danh sách điểm rèn luyện",
                                        style: TextStyle(fontSize: 17.sp,
                                            color: Colors.white),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.cyanAccent,
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(AppRouter.GPAHOMELISTEXPORT,arguments: snapshot.data.toString());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.home_outlined, size: 25.sp),
                              SizedBox(height: 1.h),
                              Text("Danh sách điểm ở nhà",
                                style: TextStyle(fontSize: 17.sp),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

}
