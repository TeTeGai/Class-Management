import 'package:luan_an/data/repository/auth_repository/firebase_auth_repo.dart';
import 'package:luan_an/data/repository/class_repository/firebase_class_repo.dart';
import 'package:luan_an/data/repository/repository.dart';
import 'package:luan_an/data/repository/student_repository/firebase_student_repo.dart';

class AppRepository {
  /// Repository
  static final authRepository = FirebasaeAuthRepository();
  static final userRepository = UserAuthRepository();
  static final classRepository = FirebaseClassRepository();
  static final studentRepository = FirebaseStudentRepository();
  /// Singleton factory
  static final AppRepository _instance = AppRepository._internal();

  factory AppRepository() {
    return _instance;
  }

  AppRepository._internal();
}