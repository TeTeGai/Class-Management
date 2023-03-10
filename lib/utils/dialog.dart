
import 'package:flutter/material.dart';

import 'loading.dart';

class UtilDialog {
  static showInformation(
      BuildContext context, {
        String? title,
        String? content,
        Function()? onClose,
      }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? "Thông báo",
          ),
          content: Text(content!),
          actions: <Widget>[
            TextButton(
              child: Text(
                "close",
              ),
              onPressed: onClose ?? () => Navigator.of(context).pop(),
            )
          ],
        );
      },
    );
  }

  static showWaiting(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 150,
            alignment: Alignment.center,
            child: Loading(),
          ),
        );
      },
    );
  }

  static hideWaiting(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<bool?> showConfirmation(
      BuildContext context, {
        String? title,
        required Widget content,
        String confirmButtonText = "Yes",
      }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title ?? "message_for_you",
          ),
          content: content,
          actions: <Widget>[
            TextButton(
              child: Text(
               "close",
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: Text(
                confirmButtonText,
              ),
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
              ),
            ),
          ],
        );
      },
    );
  }
}