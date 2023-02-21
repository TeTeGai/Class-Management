

import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:luan_an/data/repository/img_repository/img_repo.dart';
import 'package:uuid/uuid.dart';

class FirebaseImgRepository extends ImgRepository{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String> uploadImageToStorage(Uint8List file, bool isPost) async {

    Reference reference = firebaseStorage.ref().child("img").child(firebaseAuth.currentUser!.uid);
    if(isPost)
      {
        String id = const Uuid().v1();
        reference = reference.child(id);
      }
    UploadTask uploadTask = reference.putData(file);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }


  @override
   Future<List<String>> uploadFiles(List _images,bool isPost) async {
    var imageUrls = await Future.wait(_images.map((_image) =>uploadImageToStorage(_image,isPost)));
    return imageUrls;
  }

  @override
   Future<String> uploadFile(File _image,) async {
    final storageReference = FirebaseStorage.instance.ref()
        .child('file/${_image.path}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete((){ });
    return  await storageReference.getDownloadURL();
  }


}