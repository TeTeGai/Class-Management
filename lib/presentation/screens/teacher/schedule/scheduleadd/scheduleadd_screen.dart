import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/schedule_model.dart';
import 'package:luan_an/presentation/common_blocs/schedule/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/schedule/scheduleadd/widget/scheduleadd_form.dart';
class ScheduleAddScreen extends StatefulWidget {
  final ScheduleModel? scheduleModel;
  const ScheduleAddScreen({Key? key,  this.scheduleModel}) : super(key: key);

  @override
  State<ScheduleAddScreen> createState() => _ScheduleAddScreenState();
}

class _ScheduleAddScreenState extends State<ScheduleAddScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleBloc(),
      child: ScheduleAddForm(scheduleModel: widget.scheduleModel),
    );
  }
}
