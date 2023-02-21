import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart' as UL;
import 'package:url_launcher/url_launcher.dart';
class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final Uri _url = Uri.parse('https://sites.google.com/view/classappxccc');
  final Uri _url1 = Uri.parse('https://sites.google.com/view/classappchinhsach');
  Future<void> sendEmail(
      {required email, String subject = "", String body = ""}) async {
    String mail = "mailto:$email?subject=$subject&body=${Uri.encodeFull('')}";
    if (await UL.canLaunch(mail)) {
      await UL.launch(mail);
    } else {
      throw Exception("Unable to open the email");
    }
  }
  Future<void> callPhone(
      {required numberPhone,}) async {
    String mail = "tel:$numberPhone";
    if (await UL.canLaunch(mail)) {
      await UL.launch(mail);
    } else {
      throw Exception("Unable to open the email");
    }
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
  Future<void> _launchUrl1() async {
    if (!await launchUrl(_url1)) {
      throw 'Could not launch $_url1';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
        title:  ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text('Trợ giúp',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context,rootNavigator: true).pop();
            },
            color: Colors.grey,
            textColor: Colors.white,
            child: Icon(
              Icons.close,
              size: 24,
            ),
            padding: EdgeInsets.only(left: 0),
            shape: CircleBorder(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 575),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children:  [
            Container(
            padding: EdgeInsets.only(top: 10,right: 10,left: 10),
            child: Column(
              children: [
                Divider(thickness: 1.50,),
                SizedBox(height: 1.h,),
                InkWell(
                  onTap: () => _launchUrl(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 85.w,
                                  child: Text(
                                    'Giới thiệu ứng dụng',
                                    style:
                                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.navigate_next,size: 25.sp,)
                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
                Divider(thickness: 1.50,),
                SizedBox(height: 1.h,),
                InkWell(
                  onTap: () => _launchUrl1(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 85.w,
                                  child: Text(
                                    'Chính sách bảo mật',
                                    style:
                                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.navigate_next,size: 25.sp,)
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
                Divider(thickness: 1.50,),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  'Trợ Giúp',
                                  style:
                                  TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w500,color: Colors.grey),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 34.w,
                                child: Text(
                                  'Email',
                                  style:
                                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500,color: Colors.grey),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 60.w,
                                child: TextButton(

                                  onPressed:() {
                                    sendEmail(email: 'thanh31ntt@gmail.com');
                                  },
                                  child: Text(
                                    'Thanh31ntt@gmail.com',
                                    style:
                                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500,color: Colors.black),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: 1.50,),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 53.w,
                                child: Text(
                                  'Số điện thoại',
                                  style:
                                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500,color: Colors.grey),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40.w,
                                child: TextButton(

                                  onPressed:() {
                                    callPhone(numberPhone: '+84838808022');
                                  },
                                  child: Text(
                                    '+84838808022',
                                    style:
                                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500,color: Colors.red),
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ],
            ),

          ),
        ),
      ),
    );
  }
}
