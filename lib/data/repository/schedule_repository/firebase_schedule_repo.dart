
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luan_an/data/model/schedule_model.dart';
import 'package:luan_an/data/repository/schedule_repository/schedule_repo.dart';
import 'package:intl/intl.dart';
import '../../../utils/randomid.dart';

class FirebaseScheduleRepository extends ScheduleRepository {
  FirebaseScheduleRepository();
  @override
  Future<void> AddSchedule(ScheduleModel scheduleModel, String thisclass) async {
    String random =RandomId();
    var _schedulecollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("schedule");
    scheduleModel = scheduleModel.cloneWith(id: random);
    await _schedulecollection.doc(scheduleModel.id).set(scheduleModel.toMap());
  }

  @override
  Stream<List<ScheduleModel>> LoadSchedule(String thisclass,String date) {
    var _schedulecollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("schedule").where('date', isEqualTo: date);
    return _schedulecollection.snapshots().map((event) => event.docs.map((e) => ScheduleModel.fromMap(e.data())).toList());
  }

  @override
  Stream<List<ScheduleModel>> LoadSonSchedule(String classId) {
    String yesterday =DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days:1)));


    var _schedulecollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("schedule").where('date',isGreaterThan: yesterday);
    return _schedulecollection.snapshots().map((event) => event.docs.map((e) => ScheduleModel.fromMap(e.data())).toList());
  }
  @override
  Future<void> DelectSchedule(String scheduleId, String thisclass) {
    var _schedulecollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("schedule");
    _schedulecollection.doc(scheduleId).delete();
    throw UnimplementedError();
  }

  @override
  Future<void> UpdateSchedule(String scheduleId,String thisclass, String title, String note, String date, String startTime, String endTime, int colorIndex) {
    var _schedulecollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("schedule");
    _schedulecollection.doc(scheduleId).update(
      {
        'id':scheduleId,
        'title': title,
        'note': note,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
        'colorIndex': colorIndex,
      }
    );
    throw UnimplementedError();
  }
}