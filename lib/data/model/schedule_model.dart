import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel{
  final String id;
  final String title;
  final String note;
  final String date;
  final String startTime;
  final String endTime;
  final int colorIndex;

  ScheduleModel({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.colorIndex,
  });

  static ScheduleModel fromMap(Map<String, dynamic> data) {
    return ScheduleModel(
      id: data['id'] ??"",
      title: data['title']??"",
      note: data['note']??"",
      date: data['date']?? Timestamp.now(),
      startTime: data['startTime']??"",
      endTime: data['endTime']??"",
      colorIndex: data['colorIndex']??"",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'title': title,
      'note': note,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'colorIndex': colorIndex,
    };
  }

  ScheduleModel cloneWith(
  {
    id,
    title,
    note,
    date,
    startTime,
    endTime,
    colorIndex
  }) {
    return ScheduleModel(
        id: id ?? this.id,
        title: title ?? this.title,
        note: note ?? this.note,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        colorIndex: colorIndex ?? this.colorIndex);
  }
}