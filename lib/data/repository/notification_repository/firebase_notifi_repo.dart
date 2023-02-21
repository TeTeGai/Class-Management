import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../model/notification_model.dart';
import 'notifi_repo.dart';

class FirebaseNotificationRepository extends NotificationRepository {
  @override
  Future<void> AddNotifiCation(String? userId, String title, String avatar,String name, bool isSeen)  async{
    String id = const Uuid().v1();
    var _userCollection = FirebaseFirestore.instance.collection("users").doc(userId).collection("notification");
    await  _userCollection.doc(id).set(
        {
          "id":  id,
          "avatar": avatar,
          "name": name,
          "timeCreate": Timestamp.now(),
          "title": title,
          "isSeen":isSeen
        }
    );
  }

  @override
  Future<void> AddNotifiCationToClass(String title, String classId,String avatar, bool isSeen)  async{
    String id = const Uuid().v1();
    var _userCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("notification");
    await  _userCollection.doc(id).set(
        {
          "id":  id,
          "timeCreate": Timestamp.now(),
          'avatar':avatar,
          "title": title,
          "isSeen":isSeen
        }
    );
  }

  @override
  Stream<List<NotificationModel>> LoadNotification() {
    var _notifiCollection = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("notification").orderBy('timeCreate',descending: true);
    return _notifiCollection.snapshots().map((event) => event.docs.map((e) => NotificationModel.formMap(e.data())).toList());
  }

  @override
  Stream<List<NotificationModel>> ClassLoadNotification(String classId) {
    var _notifiCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("notification").orderBy('timeCreate',descending: true);
    return _notifiCollection.snapshots().map((event) => event.docs.map((e) => NotificationModel.formMap(e.data())).toList());
  }

  @override
  Future<void> NotificationUpdate(String id,String notificationId) async{
    var _notifiCollection = FirebaseFirestore.instance.collection("users").doc(id).collection("notification");
    await  _notifiCollection.doc(notificationId).update(
        {
          "isSeen": true
        }
    );
  }

  @override
  Future<void> ClassNotificationUpdate(String classId,String notificationId) async{
    var _notifiCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("notification");
    await  _notifiCollection.doc(notificationId).update(
        {
          "isSeen": true
        }
    );
  }

  @override
  Future<void> NotificationRemove(String id,String notificationId) async{
    var _notifiCollection = FirebaseFirestore.instance.collection("users").doc(id).collection("notification");
    await  _notifiCollection.doc(notificationId).delete();
  }
  @override
  Future<void> ClassNotificationRemove(String classId,String notificationId) async{
    var _notifiCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("notification");
    await  _notifiCollection.doc(notificationId).delete();
  }
}
