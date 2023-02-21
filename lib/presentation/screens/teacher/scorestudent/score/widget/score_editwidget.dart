import 'package:flutter/material.dart';
import 'package:luan_an/configs/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class ScoreEditWidget extends StatelessWidget {
  const ScoreEditWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(left: 10,top: 10),
        child: TextButton(
          onPressed: () {
            Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.EDITSCOREDETAIL);
          },
          child:  Container(
            width: 45.w,
            height: 12.h,
            decoration: BoxDecoration(
              border: Border.all(width: 1,color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(15.sp)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10,),
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25.4.sp,
                  child: CircleAvatar(radius: 25.sp,
                    backgroundColor: Colors.white,
                    child:  Center(child: Icon(Icons.edit,size: 25.sp,color: Colors.cyan,)),
                  ),
                ),
                SizedBox(width: 10,),
                ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 20.w),
                    child: Text("Chỉnh sửa",  maxLines: 2,
                        style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold,color: Colors.cyan,),textAlign: TextAlign.center)
                ),
              ],
            ),
          )
        )
    );
  }
}
