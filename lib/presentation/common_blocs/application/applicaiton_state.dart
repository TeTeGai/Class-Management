import 'package:equatable/equatable.dart';


class ApplicationSate extends Equatable{
  const ApplicationSate();

  @override
  List<Object> get props => [];
}
class ApplicationInitial extends ApplicationSate{}

class ApplicationCompleted extends ApplicationSate{}
