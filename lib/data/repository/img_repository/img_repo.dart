
import 'dart:io';
import 'dart:typed_data';

abstract class ImgRepository{
  Future<String> uploadImageToStorage(Uint8List file, bool isPost);
  Future<List<String>> uploadFiles(List _images,bool isPost);
  Future<String> uploadFile(File _image,);
}