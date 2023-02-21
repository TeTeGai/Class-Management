import 'package:flutter/material.dart';
import 'package:luan_an/configs/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class GPASonAddWidget extends StatelessWidget {
  final String GoodOrBad;
  const GPASonAddWidget({Key? key, required this.GoodOrBad,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(left: 10,top: 10),
        child: TextButton(
          onPressed: () {
            if(GoodOrBad == "Good")
              {
                Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.ADDGPASON,arguments: "Good");
              }
            else if (GoodOrBad =="Bad")
              {
                Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.ADDGPASON,arguments: "Bad");
              }
            else
              print("eror");
          },
          child:   Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25.4.sp,
                  child: CircleAvatar(radius: 25.sp,
                    backgroundColor: Colors.white,
                    child:  Center(child: Icon(Icons.edit,size: 25.sp,color: Colors.cyan,)),
                  ),
                ),
                SizedBox(height: 0.6.h,),

                Text("Thêm mới",style: TextStyle(fontSize: 17.sp,color: Colors.cyan)),
              ],
            ),
          )
        )
    );
  }
}
