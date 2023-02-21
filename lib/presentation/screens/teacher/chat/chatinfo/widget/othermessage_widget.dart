import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OhterMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final String username;
  final String type;
  final bool isSeen;
  const OhterMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.username,
    required this.isSeen,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 35.w,
            maxWidth: 55.w
        ),
        child: Card(
          elevation: 1,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.teal,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: type == "text" ?
                EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 20,
                ):
                EdgeInsets.only(
                  left: 1,
                  top: 1,
                  right: 1,
                  bottom: 1,
                ),
                child: Column(
                  children: [
                    if(type == "text")
                      ...[
                        Text(message,style: TextStyle(fontSize: 17.sp,color: Colors.white),)
                      ]
                    else if(type =="img")
                      ...[
                        Image(image: NetworkImage(message))
                      ]
                    else if(type =="file")
                        ...[
                          TextButton(
                              onPressed: ()
                              async {
                                var dir = await getExternalStorageDirectory();

                              await FlutterDownloader.enqueue(
                                url: message,

                                savedDir: dir!.path,
                                showNotification: true,
                                saveInPublicStorage: true,
                                openFileFromNotification: true,
                              );
                              },
                              child: Text('File',style: TextStyle(fontSize: 17.sp,color: Colors.tealAccent),))
                        ]
                  ],
                ),
              ),

              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      isSeen ? Icons.done_all : Icons.done,
                      size: 20,
                      color: isSeen ? Colors.blue : Colors.white60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
