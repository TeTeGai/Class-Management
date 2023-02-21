import 'package:flutter/material.dart';
import 'package:luan_an/configs/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectAccountScreen extends StatelessWidget {
  const SelectAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
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
      body: Container(
            padding: EdgeInsets.only(top: 13.h,left: 10.w),
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 13.sp),
                    children: <TextSpan>[
                      TextSpan(text: 'Vui lòng chọn loại tài khoản của bạn \n', style: TextStyle(color: Colors.grey)),
                      TextSpan(text: 'Bạn là ai? ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp)),
                    ],
                  ),
                  textScaleFactor: 2,
                ),
                classroom(title: "Giáo viên", image: "assets/7060797.jpg", description: "Tạo và quản lý lớp học của bạn", argument: true),

                classroom(title: "Phụ huynh", image: "assets/4300_2_05.jpg", description: "Giữ kết nối với con với giáo viên", argument: false)
              ],
            ),
      ),
    );
  }
}
class classroom extends StatelessWidget {
  final String image, title, description;
  final bool argument;
  classroom(
      {required this.title,
        required this.image,
        required this.description,
        required this.argument,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()
        {
         Navigator.of(context).pushNamed(AppRouter.SIGNUP,arguments:argument );
        },
        child: Container(
          margin: EdgeInsets.only(top: 2.h,right: 2.h),
          height: 18.h,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white),
          child: Row(
            children: [
              SizedBox(width: 2.h,),
              Container(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(100.h)),
                      child: Container(
                        height: 13.h,
                        width: 26.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 5.sp),
                          children: <TextSpan>[
                            TextSpan(text: "$title\n",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                            TextSpan(text: "$description\n",style: TextStyle(fontSize: 15.sp)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}