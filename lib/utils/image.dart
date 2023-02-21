import 'package:image_picker/image_picker.dart';
PickImg(ImageSource source) async
{
  final ImagePicker _img = ImagePicker();
  XFile? _file = await _img.pickImage(source: source);
  if(_file != null)
    {
      return await _file.readAsBytes();
    }
  print("No img select");
}