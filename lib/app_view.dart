import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/repository/repository.dart';
import 'package:luan_an/presentation/common_blocs/auth/bloc.dart';
import 'package:luan_an/presentation/common_blocs/common.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:luan_an/utils/localnotificationservice.dart';
import 'package:luan_an/utils/pushnotifications.dart';
import 'main.dart';
import 'presentation/common_blocs/application/bloc.dart';
import 'presentation/common_blocs/profile/bloc.dart';
class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  UserAuthRepository userAuthRepository = UserAuthRepository();
  NavigatorState? get _navigator => _navigatorKey.currentState;
  late String deviceToken;
  @override
  void initState() {
    CommonBloc.applicationBloc.add(SetupApplication());
    init();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);


    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },

    );

    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }


  void loadData() {
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    CommonBloc.dispose();
    super.dispose();
  }

  void onNavigator(String route)
  {
    _navigator?.pushNamedAndRemoveUntil(route, (route) => false);
  }
  init()
  async{
    deviceToken = await getDeviceToken();
    print("tokennnnnnnnnnnnnnnnnnnnnnn");
    print(deviceToken);
    print("###############################");

  }

  Future getDeviceToken() async
  {
    FirebaseMessaging _firebasemessaging = FirebaseMessaging.instance;
    String? deviceToken = await _firebasemessaging.getToken();
    return (deviceToken == null)?"": deviceToken;
  }
  ReceivePort _port = ReceivePort();



  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
        return BlocBuilder<ApplicationBloc,ApplicationSate>(builder: (context, appstate) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const  Locale('vi','VN'),
            ],
            navigatorKey: _navigatorKey,
            onGenerateRoute: AppRouter.router,
            initialRoute:AppRouter.SPLASH,
            builder: (context, child) {
              return BlocListener<AuthBloc,AuthState>(listener: (context, state) {
                if(appstate is ApplicationCompleted)
                  {
                    if(state is Authenticated) {
                      loadData();
                      onNavigator(AppRouter.CLASSSELECT);
                      userAuthRepository.updateUserData({'pushToken': deviceToken});
                    }
                    if(state is AuthenticatedParent) {
                      onNavigator(AppRouter.HOMEPARENT);
                      userAuthRepository.updateUserData({'pushToken': deviceToken});
                    }
                    else if(state  is Uninitialized)
                      {
                        onNavigator(AppRouter.SPLASH);
                      }
                    else if(state is Unauthenticated)
                      {
                        onNavigator(AppRouter.LOGIN);
                      }
                  }
                else
                  {
                    onNavigator(AppRouter.SPLASH);

                  }
                },
                  child: child
              );
            },
          );
        },);

  }
}
