import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/schedule_model.dart';
import 'package:luan_an/presentation/common_blocs/schedule/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../../../../../data/repository/schedule_repository/firebase_schedule_repo.dart';


class ScheduleForm extends StatefulWidget {
  final DateTime date;
  final String classId;

  const ScheduleForm({Key? key, required this.date, required this.classId}) : super(key: key);

  @override
  State<ScheduleForm> createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> with AutomaticKeepAliveClientMixin<ScheduleForm>{
  late ScheduleBloc scheduleBloc;

  List<Color> colors = [Colors.blueAccent, Colors.pink, Colors.yellow];
  @override
  void initState()  {
  initializeDateFormatting('vi');
  scheduleBloc =BlocProvider.of<ScheduleBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
  super.dispose();
  }
  @override
  Widget build(BuildContext context) {
            return Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseScheduleRepository().LoadSchedule(widget.classId, DateFormat('yyyy-MM-dd').format(widget.date)),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ScheduleModel>> snapshot) {
                      if (!snapshot.hasData) return Center();
                      return  AnimationLimiter(
                        child: ListView.builder(
                            key: UniqueKey(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var schedule = snapshot.data![index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: SafeArea(
                                        child: Column(
                                          children: [
                                            Dismissible(
                                              key: UniqueKey(),
                                              onDismissed: (direction) {
                                                scheduleBloc.add(ScheduleRemove(schedule.id));
                                              },
                                              background: Container(
                                                padding: const EdgeInsets.all(10),
                                                margin: const EdgeInsets.symmetric(vertical: 12),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.red,
                                                ),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                  size: 40,
                                                ),
                                                alignment: Alignment.centerLeft,
                                              ),
                                              child: GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.SCHEDULEADD,arguments:snapshot.data![index] );
                                                },
                                                child: Container(
                                                  width: 95.w,
                                                  height: 20.h,
                                                  margin: EdgeInsets.symmetric(vertical: 1.h),
                                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: colors[schedule.colorIndex],
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        schedule.title,
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
                                                            schedule.startTime +'-' +schedule.endTime,
                                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                              color: Colors.white,
                                                              fontSize: 20.sp,
                                                              fontWeight: FontWeight.w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        schedule.note,
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
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      );
                    },

                  ),
                ),
              ],
            );
          }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
