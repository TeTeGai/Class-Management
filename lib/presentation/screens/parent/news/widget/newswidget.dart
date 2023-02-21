import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc.dart';
import 'like_animation.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> with AutomaticKeepAliveClientMixin<NewsWidget>{

  late NewsBloc newsBloc;
  bool isLikeAnimating = false;
  String firebaseAuth = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    newsBloc = BlocProvider.of<NewsBloc>(context);
    super.initState();
  }
  Future onLike(List like,String postId,String classId) async {
    return newsBloc.add(
        NewsLikesParentLoad(like, postId,classId)
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <NewsBloc,NewsState>(
      builder: (context, state) {
        if(state is NewsLoading)
        {
          return Center(child: CircularProgressIndicator());
        }
        if(state is NewsParentLoaded)
        {
          var newsModel = state.newsModel;
          return newsModel.length>0 ? ListView.builder(
              key: UniqueKey(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: newsModel.length,
              itemBuilder: (context, index) {

                return   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // NewsHeader(id: newsModel[index].idUser),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22.sp,
                                    backgroundImage: NetworkImage(newsModel[index].avatarUser.toString()),
                                  ),

                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(newsModel[index].nameUser,style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold,fontSize: 20.sp),),
                                      Row(
                                        children: [
                                          Text(DateFormat.yMd().add_jm().format(newsModel[index].datePost.toDate()), style: TextStyle(color: Colors.cyan),),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 1.h,),
                      Row(
                        children: [
                          Text(newsModel[index].text, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold,fontSize: 20.sp),),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      newsModel[index].porfImg.length > 0 ? SizedBox(
                        height: 40.h,
                        width:  100.w,
                        child: GestureDetector(
                          onDoubleTap: () {
                            onLike(newsModel[index].likes,newsModel[index].id,newsModel[index].classId);
                            setState(() {
                              isLikeAnimating = true;
                            });
                          },
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount:  newsModel[index].porfImg.length,
                              key: UniqueKey(),
                              itemBuilder: (context, index2) =>
                                  Container(
                                      height: 40.h,
                                      width:  100.w,
                                      child: FittedBox(
                                        child: Image.network(newsModel[index].porfImg[index2].toString(),),
                                        fit: BoxFit.fill,
                                      )
                                  )


                          ),

                          // child: PhotoViewGallery.builder(
                          //    scrollPhysics: const BouncingScrollPhysics(),
                          //    builder: (BuildContext context, int index2) {
                          //      return PhotoViewGalleryPageOptions(
                          //        imageProvider:   NetworkImage(
                          //          newsModel[index].porfImg[index2].toString(),
                          //        ),
                          //        initialScale: PhotoViewComputedScale.contained * 0.8,
                          //      );
                          //    },
                          //    itemCount:  newsModel[index].porfImg.length,
                          //    loadingBuilder: (context, event) => Center(
                          //      child: Container(
                          //        width: 20.0,
                          //        height: 20.0,
                          //        child: CircularProgressIndicator(),
                          //      ),
                          //    ),
                          //
                          //  )

                          // AnimatedOpacity(
                          //   duration: const Duration(milliseconds: 200),
                          //   opacity: isLikeAnimating ? 1.0 : 0.0,
                          //   child: LikeAnimation(
                          //     isAnimating: isLikeAnimating,
                          //     child: const Icon(
                          //       Icons.favorite,
                          //       color: Colors.white,
                          //       size: 100,
                          //     ),
                          //     duration: const Duration(
                          //       milliseconds: 400,
                          //     ),
                          //     onEnd: () {
                          //       setState(() {
                          //         isLikeAnimating = false;
                          //       });
                          //     },
                          //   ),
                          // ),

                        ),
                      ) : Container(),
                      SizedBox(height: 1.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              LikeAnimation(
                                isAnimating: newsModel[index].likes.contains(firebaseAuth),
                                smalliked: true,
                                child: GestureDetector(
                                  onLongPress: (){
                                    Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.LIKES,arguments:newsModel[index] );
                                  },
                                  child: IconButton(
                                    onPressed: () =>  onLike(newsModel[index].likes,newsModel[index].id,newsModel[index].classId),
                                    icon:  newsModel[index].likes.contains(firebaseAuth)   ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                        : const Icon(
                                      Icons.favorite_border,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: (){
                                Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.COMMENTPARENT,arguments: newsModel[index]);
                              }, icon:  Icon(Icons.message_outlined, color: Colors.grey,),),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

          ):Center();


        }
        return Center();
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
