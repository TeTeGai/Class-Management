import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/schedule/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CalendarScreen extends StatefulWidget {
  String? classId;
   CalendarScreen({Key? key, required this.classId,}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Color> colors = [Colors.blueAccent, Colors.pink, Colors.yellow];

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
            child: Text('Lịch',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
      ),
      body: BlocBuilder <ScheduleBloc,ScheduleState>(
        bloc: ScheduleBloc()..add(ScheduleSonLoad(widget.classId!)),
        builder: (context, state) {
          if(state is ScheduleLoading)
          {
            return Center(child: CircularProgressIndicator());
          }
          if(state is ScheduleSonLoaded)
          {
            var scheduleModel = state.scheduleModel;
            return scheduleModel.length>0 ? ListView.builder(
                key: UniqueKey(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: scheduleModel.length,
                itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                      width: 50.w,
                      height: 25.h,
                      margin: EdgeInsets.symmetric(vertical: 1.h),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors[scheduleModel[index].colorIndex],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scheduleModel[index].title,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.watch,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                scheduleModel[index].startTime +'-' +scheduleModel[index].endTime,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                scheduleModel[index].date,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            scheduleModel[index].note,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                 );
                }

            ):Center();

          }
          return Center();
        },
      )
    );
  }
}
