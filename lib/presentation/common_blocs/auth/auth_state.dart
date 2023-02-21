import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthState extends Equatable{
  const AuthState ();

  @override
  List<Object> get props => [];
}
class Uninitialized extends AuthState{}

class Authenticated  extends AuthState{
  final User loggedFirebaseUser;
  const Authenticated (this.loggedFirebaseUser);
  @override
  List<Object> get props => [loggedFirebaseUser];
  @override
  String toString() {
    return 'Authenticated{email: ${this.loggedFirebaseUser.email}}';
  }
}

class AuthenticatedParent  extends AuthState{
  final User loggedFirebaseUser;
  const AuthenticatedParent (this.loggedFirebaseUser);
  @override
  List<Object> get props => [loggedFirebaseUser];
  @override
  String toString() {
    return 'Authenticated{email: ${this.loggedFirebaseUser.email}}';
  }
}

class Unauthenticated extends AuthState{}