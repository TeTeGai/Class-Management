
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../data/model/score_model.dart';
import '../../../../../../utils/snackbar.dart';
import '../../../../../common_blocs/score/bloc.dart';




class ScoreAddForm extends StatefulWidget {
  const ScoreAddForm({Key? key}) : super(key: key);

  @override
  State<ScoreAddForm> createState() => _ScoreAddFormState();
}

class _ScoreAddFormState extends State<ScoreAddForm> {
  late ScoreBloc scoreBloc;
  late ScoreModel scoreModel;
  List typeScore= ["Kiểm tra miệng"];
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController scoreEditingController = TextEditingController();
  TextEditingController listTypeEditingController = TextEditingController();
  String img = "assets/questions.png";
  List<String> scoreImgList = ["assets/basketball-ball.png","assets/flask.png",
    "assets/atom.png","assets/black-history-month.png","assets/world-globe.png",
    "assets/art-art.png","assets/musical-notes.png","assets/maths.png",
    "assets/computer.png","assets/biology.png","assets/book-book.png",
    "assets/liquid-glue.png"
  ];
  @override
  void initState() {
    scoreBloc = BlocProvider.of<ScoreBloc>(context);
    super.initState();
  }
  @override
  void dispose() {
    scoreBloc.close();
    // TODO: implement dispose
    super.dispose();
  }
  void onPress()
  {
    if(nameEditingController.text.trim().isNotEmpty &&  scoreEditingController.text.trim().isNotEmpty)
      {
        ScoreModel score;
        int s = int.parse(scoreEditingController.text);
        score = ScoreModel(id:'',title: nameEditingController.text,score: s,avatar: img,category: typeScore);
        scoreModel = score.cloneWith();
        try{
          scoreBloc.add(ScoreAdd(scoreModel));
          Navigator.of(context).pop();
          MySnackBar.error(message: "Đã thêm điểm môn học mới", color: Colors.cyan, context: context,);
        }
        catch(e)
       {
         MySnackBar.error(message: "Có lỗi đã xảy ra vui lòng thử lại", color: Colors.red, context: context,);
       }
      }
    else{
      MySnackBar.error(message: "Chưa đủ thông tin", color: Colors.red, context: context,);
    }

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc,ScoreState>(
      builder: (context, state) {
        return  Column(
          children: [
                Center(
                  child: GestureDetector(
                    onTap: ()
                    {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 40.h,
                            color: Colors.grey.shade200,
                            child: GridView.builder(
                              itemCount:scoreImgList.length ,
                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              key: UniqueKey(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return   Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      setState(() {
                                        img = scoreImgList[index];
                                      });
                                    },
                                    child: Container(
                                      height: 8.h,
                                      width: 8.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(scoreImgList[index]),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                );
                              },

                            ),

                          );
                        },
                      );
                    },
                    child: CircleAvatar(radius: 35.sp,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(img),
                    ),
                  ),
                ),



            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: nameInput(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: scoreInput(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: listScoreInput(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                key: UniqueKey(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: typeScore.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 5.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                    ),
                      child:Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 30.w),
                              child: Text(typeScore[index], maxLines: 3,
                                  style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center)
                          ),
                        ),
                        IconButton(onPressed: (){
                          setState(() {
                            typeScore.remove(typeScore[index]);
                          });
                        }, icon: Icon(Icons.close,size: 15.sp,))
                      ],
                    )
                    ),
                  );
                },

              ),
            ),

            Container(
              width: 85.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black54),
                    top: BorderSide(color: Colors.black54),
                    left: BorderSide(color: Colors.black54),
                    right: BorderSide(color: Colors.black54),
                  )
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: () {
                  onPress();
                },
                color: Colors.cyan,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("Thêm điểm môn học", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white
                ),),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 5.h))
          ],
        );
      },
    );
  }
  Widget nameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(

          controller: nameEditingController,
          decoration: InputDecoration(
            labelText: "Tên môn học" + "*",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }


  Widget scoreInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.number,
          controller: scoreEditingController,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: "Thang điểm" + "*",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
  Widget listScoreInput() {
    return Column(
      children: <Widget>[
        TextField(
          controller: listTypeEditingController,
          decoration: InputDecoration(
            labelText: "Thêm loại điểm" + "*",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  typeScore.add(listTypeEditingController.text);
                });

              },
              icon: Icon(Icons.add),
            ),
          ),

        ),
        SizedBox(height: 20,),
      ],
    );
  }

}
