import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/schedule_model.dart';
import 'package:luan_an/presentation/common_blocs/schedule/bloc.dart';

class ScheduleState extends Equatable{
  const ScheduleState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScheduleLoading extends ScheduleState{}

class ScheduleLoaded extends ScheduleState{
  final List<ScheduleModel> scheduleModel;
  const ScheduleLoaded(this.scheduleModel);
  @override
  // TODO: implement props
  List<Object?> get props => [scheduleModel];
}


class ScheduleSonLoaded extends ScheduleState{
  final List<ScheduleModel> scheduleModel;
  const ScheduleSonLoaded(this.scheduleModel);
  @override
  // TODO: implement props
  List<Object?> get props => [scheduleModel];
}

class ScheduleLoadFail extends ScheduleState{
  final String error;
  const ScheduleLoadFail(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}