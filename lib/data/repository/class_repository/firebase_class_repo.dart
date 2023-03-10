
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/gpa_model.dart';
import 'package:luan_an/data/model/score_model.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/data/repository/class_repository/class_repo.dart';

import '../../../utils/randomid.dart';
import '../img_repository/firebase_img_repo.dart';

class FirebaseClassRepository implements ClassRepository{

  var _classcollection =FirebaseFirestore.instance.collection("class");
  @override
  Future<void> createClass(ClassModel classModel,Uint8List? file,String? img) async {
    String random =RandomId();
    if(file!= null)
      {
        String photoUrl = await FirebaseImgRepository().uploadImageToStorage( file, true);
        classModel = classModel.cloneWith(id: random,avatar: photoUrl);
        await _classcollection.doc(classModel.id).set(classModel.toMap());
        AddInitScore(random);
        AddInitGPA(random);
      }
    else
      {
        classModel = classModel.cloneWith(id: random,avatar: img);
        await _classcollection.doc(classModel.id).set(classModel.toMap());
        AddInitScore(random);
        AddInitGPA(random);
      }


  }

  @override
  // TODO: implement loggedFirebaseUser
  User get loggedFirebaseUser => throw UnimplementedError();

  @override
  Stream<List<ClassModel>> loadClass(String uid)  {
    var _classcollection =FirebaseFirestore.instance.collection("class").where("member",arrayContainsAny: [uid]).orderBy('timeCreate');
    return _classcollection.snapshots().map((event) => event.docs.map((e) => ClassModel.formMap(e.data())).toList());

  }





  static final FirebaseClassRepository _instance = FirebaseClassRepository._internal();
  factory FirebaseClassRepository()
  {
    return _instance;
  }
  FirebaseClassRepository._internal();

  @override
  Future<void> AddInitScore(String classId) async{
    List listCategory = ["Ki???m tra mi???ng","Ki???m tra 15p","Ki???m tra 1 ti???t","Ki???m tra h???c k?? 1","Ki???m tra h???c k?? 2"];
    String randomScore1 =RandomId();
    String randomScore2 =RandomId();
    String randomScore3 =RandomId();
    var _scorecollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("score");
    ScoreModel scoreModel1 = new ScoreModel(id: randomScore1, title: "To??n h???c", avatar: "assets/maths.png", score: 10, category: listCategory);
    ScoreModel scoreModel2 = new ScoreModel(id: randomScore2, title: "Th??? d???c", avatar: "assets/basketball-ball.png", score: 10, category: listCategory);
    ScoreModel scoreModel3 = new ScoreModel(id: randomScore3, title: "H??a h???c", avatar: "assets/flask.png", score: 10, category: listCategory);
    await _scorecollection.doc(scoreModel1.id).set(scoreModel1.toMap());
    await _scorecollection.doc(scoreModel2.id).set(scoreModel2.toMap());
    await _scorecollection.doc(scoreModel3.id).set(scoreModel3.toMap());

  }

  @override
  Future<void> AddInitGPA(String classId) async{
    String randomScore1 =RandomId();
    String randomScore2 =RandomId();
    String randomScore3 =RandomId();
    String randomScore4 =RandomId();
    String randomScore5 =RandomId();
    String randomScore6 =RandomId();
    var _scorecollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpa");
    GPAModel gpaModel1 = new GPAModel(id: randomScore1, title: "Ch??m ch???", avatar: "assets/check-list.png", score: 10, category: "GoodGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel2 = new GPAModel(id: randomScore2, title: "Tinh th???n ??o??n k???t t???t", avatar: "assets/real-estate.png", score: 10, category: "GoodGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel3 = new GPAModel(id: randomScore3, title: "Ph??t bi???u ????ng", avatar: "assets/student.png", score: 10, category: "GoodGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel4 = new GPAModel(id: randomScore4, title: "Ng??? g???c", avatar: "assets/zzz.png", score: -10, category: "BadGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel5= new GPAModel(id: randomScore5, title: "Hay ????nh nhau", avatar: "assets/sword.png", score: -10, category: "BadGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel6 = new GPAModel(id: randomScore6, title: "Ch??a thu???c b??i", avatar: "assets/mental-health.png", score: -10, category: "BadGPA",timeCreate: Timestamp.now());
    await _scorecollection.doc(gpaModel1.id).set(gpaModel1.toMap());
    await _scorecollection.doc(gpaModel2.id).set(gpaModel2.toMap());
    await _scorecollection.doc(gpaModel3.id).set(gpaModel3.toMap());
    await _scorecollection.doc(gpaModel4.id).set(gpaModel4.toMap());
    await _scorecollection.doc(gpaModel5.id).set(gpaModel5.toMap());
    await _scorecollection.doc(gpaModel6.id).set(gpaModel6.toMap());
  }

  @override
  Future<void> joinClass(String classId,String userId) {
    return _classcollection.doc(classId).update(
      {
        'member':  FieldValue.arrayUnion([userId])
      }
    );
  }
  @override
  Future<void> deleteClass(String classId) async {
    return await _classcollection.doc(classId).delete();
  }

  @override
  Future<void> getOutClass(String classId) async {
    return await _classcollection.doc(classId).update(
        {
          'member':  FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
        }
    );
  }
  @override
  Future<void> editClass(ClassModel classModel,Uint8List? file,String? img) async {
    if(file!= null)
      {
        String photoUrl = await FirebaseImgRepository().uploadImageToStorage( file, true);
        _classcollection.doc(classModel.id).update(
            {
              'className':classModel.className,
              'gradeName':classModel.gradeName,
              'schoolName':classModel.schoolName,
              'avatar':photoUrl,
            }
        );
      }
    else{
      _classcollection.doc(classModel.id).update(
          {
            'className':classModel.className,
            'gradeName':classModel.gradeName,
            'schoolName':classModel.schoolName,
            'avatar':img,
          }
      );
    }
  }
}