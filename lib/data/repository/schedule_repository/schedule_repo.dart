

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luan_an/data/model/schedule_model.dart';

abstract class ScheduleRepository {
  Future<void> AddSchedule(ScheduleModel scheduleModel,String thisclass);
  Future<void> DelectSchedule(String scheduleId,String thisclass);
  Stream<List<ScheduleModel>> LoadSchedule(String thisclass,String date);
  Future<void> UpdateSchedule(String scheduleId,String thisclass, String title, String note, String date, String startTime, String endTime, int colorIndex );
}