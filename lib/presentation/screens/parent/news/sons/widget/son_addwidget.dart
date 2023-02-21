import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../configs/router.dart';

class SonAddWidget extends StatelessWidget {
  const SonAddWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: const EdgeInsets.only(left: 10,top: 10),
        child: TextButton(onPressed: ()=>Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.ADDSON), child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start ,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 24.4.sp,
              child:
              CircleAvatar(radius: 24.sp,
                backgroundColor: Colors.cyan,
                child:  Center(child: Icon(Icons.add,size: 30.sp,color: Colors.white,),),
              ),
            ),
            SizedBox(width: 2.w,),
            Text("Thêm mới",style: TextStyle(fontSize: 17.sp,color: Colors.cyan)),
          ],
        ),)
    );
  }
}
