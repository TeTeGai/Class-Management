
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class NotificationRepository {
  AddNotifiCation(String? userId, String title, String avatar,String name, bool isSeen);
}