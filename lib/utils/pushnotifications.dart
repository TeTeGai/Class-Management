import 'dart:convert';

import 'package:http/http.dart' as http;
class PushNotifications{
  static Future<bool> callOnFcmApiSendPushNotifications(
      { required String body,required String To,String? url}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": To,
      "notification": {
        "title": "Class App",
        "body": body,
        "mutable_content": true,
        "sound": "Tri-tone",
        "android_channel_id": "pushnotificationapp",
        "image": url
      },
      "data": {
        "title": "Class App",
        "body": body,
        "image": url,
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=AAAAbuS3jjY:APA91bFlYVk5su1PXS9aSYHBRB7ikVlVB7xQxF3rHfmkjwChE5Y37_BJSi-tulttUV0usDEsRTMhv-FvXgvTsdyw8RXt25YMMzRm8fJVJuhBmN_yxfgB5MTriIFSezauITtqgXxUYXul' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }
  static final PushNotifications _instance = PushNotifications._internal();
  factory PushNotifications() {
    return _instance;
  }
  PushNotifications._internal();
}
