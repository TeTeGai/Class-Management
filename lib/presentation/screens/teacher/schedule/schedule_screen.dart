import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/schedule/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/schedule/widget/schedule_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../../configs/router.dart';

class ScheduleScreen extends StatefulWidget {
  final String classId;
  const ScheduleScreen({Key? key, required this.classId}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  var currentdate = DateTime.now();
  @override
  void initState()  {
    initializeDateFormatting('vi');

    // fetchItems();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => ScheduleBloc(),
      child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
              title:  ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Text('Lịch học',  maxLines: 4,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context,rootNavigator: true).pop();
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
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("class").doc(widget.classId).collection("notification").where("isSeen",isEqualTo: false).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return IconButton(
                        onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.CLASSNOTIFICATION),
                        icon: Stack(
                          children: [
                            Icon(Icons.notifications_none_outlined,size: 22.sp,color: Colors.grey,),
                            if (snapshot.hasData)
                              ...[
                                snapshot.data!.docs.length>0?
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.white
                                        ),
                                        borderRadius: BorderRadius.circular(100.0),
                                        color: Colors.red,
                                      ),
                                      child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                                    )
                                ):   Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.white
                                        ),
                                        borderRadius: BorderRadius.circular(100.0),
                                        color: Colors.red,
                                      ),)
                                ),
                              ]


                          ],
                        )
                    );
                  },

                ),
              ],
            ),
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        DateFormat.MMMMd('vi').format(currentdate),
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 25.sp),
                      ),
                      const Spacer(),
                      Container(
                        width: 40.w,
                        padding: EdgeInsets.symmetric(vertical: 0.1.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.cyan,
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.SCHEDULEADD2);
                          },
                          child: Text(
                            "+ Thêm mới",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 18.sp, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                  child: DatePicker(
                    DateTime.now(),
                    locale: 'vi',
                    width: 20.w,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Colors.cyan,
                    onDateChange: (DateTime newdate) {
                      setState(() {
                        currentdate = newdate;
                      });
                    },
                  ),
                ),
                Expanded(child: ScheduleForm(date: currentdate,classId: widget.classId,)),
              ],
            )

      ),
    );
  }
}
