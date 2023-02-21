import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luan_an/data/model/comment_model.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:luan_an/data/repository/chat_repository/firebase_chat_repo.dart';
import 'package:luan_an/data/repository/img_repository/firebase_img_repo.dart';
import 'package:luan_an/data/repository/news_repository/news_repo.dart';
import 'package:luan_an/data/repository/repository.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/randomid.dart';

class FirebaseNewsRepository extends NewsRepository
{

  @override
  Future<void> AddNews(NewsModel newsModel, String thisclass, List file) async {
    String random =RandomId();
    String postId = const Uuid().v1();
    var _newscollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("news");
    Timestamp now = Timestamp.now();
    List<String> photoUrl = await FirebaseImgRepository().uploadFiles(file, true);
    newsModel = newsModel.cloneWith(id: random,postId: postId,datePost: now,porfImg: photoUrl,classId: thisclass);
    await _newscollection.doc(newsModel.id).set(newsModel.toMap());
  }

  @override
  Stream<List<NewsModel>> LoadNews(String thisclass) {
    var _newscollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("news").orderBy('datePost',descending: true);
    return _newscollection.snapshots().map((event) => event.docs.map((e) => NewsModel.formMap(e.data())).toList());
  }

  @override
  Stream<List<NewsModel>> LoadParentNews(List classId) {
    var _newscollection = FirebaseFirestore.instance.collectionGroup('news').where('classId',whereIn: classId).orderBy('datePost',descending: true);
    return _newscollection.snapshots().map((event) => event.docs.map((e) => NewsModel.formMap(e.data())).toList());
  }


  @override
  Future<void> likeNews(String postId, String uid, List like,String thisclass) async {
    var _newscollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("news");
    if(like.contains(uid))
      {
        await _newscollection.doc(postId).update({
          'likes' : FieldValue.arrayRemove([uid])
        });
      }
    else{
      await _newscollection.doc(postId).update({
        'likes' : FieldValue.arrayUnion([uid])
      });
    }
  }





  @override
  Future<void> AddCmt(CommentModel cmtModel, String thisclass, String thispost) async{
    String random =RandomId();
    var _cmtcollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("news").doc(thispost).collection("comment");
    Timestamp now = Timestamp.now();
    cmtModel = cmtModel.cloneWith(id: random,likes: [],timeCmt: now);
    await _cmtcollection.doc(cmtModel.id).set(cmtModel.toMap());
  }

  @override
  Stream<List<CommentModel>> LoadCmt(String thisclass, thispost) {
    var _cmtcollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("news").doc(thispost).collection("comment").orderBy('timeCmt');
    return _cmtcollection.snapshots().map((event) => event.docs.map((e) => CommentModel.formMap(e.data())).toList());
  }



  @override
  Future<void> DeleteNews( String thisclass, String postId) async {
    var _newscollection = FirebaseFirestore.instance.collection("class").doc(thisclass).collection("news");
    await _newscollection.doc(postId).delete();
  }

}