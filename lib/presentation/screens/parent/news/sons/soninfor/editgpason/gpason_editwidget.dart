import 'package:flutter/material.dart';
import 'package:luan_an/configs/router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../../utils/snackbar.dart';


class GPASonEditWidget extends StatelessWidget {
  final String GoodOrBad;
  final bool isConnect;
  const GPASonEditWidget({Key? key, required this.GoodOrBad, required this.isConnect,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextButton(
          onPressed: () {
            if( isConnect)
              {
                if(GoodOrBad == "Good")
                {
                  Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.EDITSONGPAGOOD);
                }
                else if (GoodOrBad =="Bad")
                {
                  Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.EDITSONGPABAD);
                }
              }

            else {
            {
              MySnackBar.error(message: "Vui lòng kết nối tới lớp học", color: Colors.red, context: context);
            }
          }
        },
          child:  Container(
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

            Text("Chỉnh sửa",style: TextStyle(fontSize: 17.sp,color: Colors.cyan)),
          ],
            ),
          )
        );

  }
}
