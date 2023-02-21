import 'dart:math';

String RandomId(){
   const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  var _rng = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rng.nextInt(_chars.length))));
  var random = getRandomString(7);
  return random;
}