class UtilValidators{
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
  );
  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }
  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
  static isValidFirstName(String firstname) {
    return firstname.isNotEmpty;
  }
  static isLastFirstName(String lastname) {
    return lastname.isNotEmpty;
  }
  static isNotEmpty(String text) {
    return text.isNotEmpty;
  }
  static final UtilValidators _instance = UtilValidators._internal();
  factory UtilValidators() {
    return _instance;
  }
  UtilValidators._internal();
}