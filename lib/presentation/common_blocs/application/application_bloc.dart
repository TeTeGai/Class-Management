import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/configs.dart';
import 'package:luan_an/presentation/common_blocs/auth/bloc.dart';
import 'package:luan_an/presentation/common_blocs/common.dart';
import 'bloc.dart';


class ApplicationBloc extends Bloc<ApplicationEvent,ApplicationSate>{

  ApplicationBloc() : super(ApplicationInitial()){
   on<SetupApplication>((event, emit)  async
   {
     await mapEventToState(emit, event);
   });
  }
}
Future <void> mapEventToState(Emitter<ApplicationSate> emit, SetupApplication event) async {
  final Application application = Application();
  await application.setPreferences();
  CommonBloc.authencationBloc.add(AuthenticationStarted());
  emit(ApplicationCompleted());
}