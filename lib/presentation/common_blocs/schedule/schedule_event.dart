import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/schedule_model.dart';
import 'package:luan_an/presentation/common_blocs/schedule/bloc.dart';

class ScheduleEvent extends Equatable{
  const ScheduleEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScheduleLoad extends ScheduleEvent{
  final String date;
  ScheduleLoad(this.date);
  @override
  // TODO: implement props
  List<Object?> get props => [date];
}
class ScheduleSonLoad extends ScheduleEvent{
  final String classId;
  ScheduleSonLoad(this.classId);
  @override
  // TODO: implement props
  List<Object?> get props => [classId];
}


class ScheduleAdd extends ScheduleEvent{
  final ScheduleModel scheduleModel;
  final String title;
  ScheduleAdd(this.scheduleModel,this.title);
  @override
  // TODO: implement props
  List<Object?> get props => [scheduleModel,title];
}
class ScheduleRemove extends ScheduleEvent{
  final String scheduleId;
  ScheduleRemove(this.scheduleId);
  @override
  // TODO: implement props
  List<Object?> get props => [scheduleId];
}

class ScheduleUpdateModel extends ScheduleEvent{
  String scheduleId, title,  note,  startTime,  endTime;
      int colorIndex;
      String date;
  ScheduleUpdateModel(this.scheduleId,this.title,this.note,this.date,this.startTime,this.endTime,this.colorIndex);
  @override
  // TODO: implement props
  List<Object?> get props => [this.scheduleId,this.title,this.note,this.date,this.startTime,this.endTime,this.colorIndex];
}

class ScheduleUpdateLoad extends ScheduleEvent{}

class ScheduleUpdate extends ScheduleEvent{
  final List<ScheduleModel> scheduleModel;
  const ScheduleUpdate(this.scheduleModel);
  @override
  // TODO: implement props
  List<Object?> get props => [scheduleModel];
}
class ScheduleSonUpdate extends ScheduleEvent{
  final List<ScheduleModel> scheduleModel;
  const ScheduleSonUpdate(this.scheduleModel);
  @override
  // TODO: implement props
  List<Object?> get props => [scheduleModel];
}