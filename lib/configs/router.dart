import 'package:flutter/material.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:luan_an/data/model/schedule_model.dart';
import 'package:luan_an/data/model/score_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/hometeacher.dart';
import 'package:luan_an/presentation/screens/login/login/login_screen.dart';
import 'package:luan_an/presentation/screens/parent/news/comment/commentparent_screen.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/request/requesttoclass_screen.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/soninfor/soninfor_screen.dart';
import 'package:luan_an/presentation/screens/signup/sigupteacher_screen.dart';
import 'package:luan_an/presentation/screens/teacher/class/add/add_screen.dart';
import 'package:luan_an/presentation/screens/teacher/classselect/joinclass/joinclass_screen.dart';
import '../homeparent.dart';
import '../presentation/screens/changepassword/changepassword.dart';
import '../presentation/screens/login/selectaccount_screen.dart';
import '../presentation/screens/parent/news/sons/calendar/calendar_screen.dart';
import '../presentation/screens/parent/news/sons/connectson/connectson_screen.dart';
import '../presentation/screens/parent/news/sons/request/addrequest/addrequest_screen.dart';
import '../presentation/screens/parent/news/sons/soninfor/addgpason/gpaaddson_form.dart';
import '../presentation/screens/parent/news/sons/soninfor/editgpason/editsongpabad_form.dart';
import '../presentation/screens/parent/news/sons/soninfor/editgpason/editsongpagood_form.dart';
import '../presentation/screens/parent/news/sons/soninfor/editsongpa_screen.dart';
import '../presentation/screens/parent/news/sons/statisticson_screen.dart';
import '../presentation/screens/parent/notification/notification_screen.dart';
import '../presentation/screens/splash/splash_srceen.dart';
import '../presentation/screens/teacher/chat/chatadd/chatadd/chatappadd_screen.dart';
import '../presentation/screens/teacher/chat/chatinfo/chatinfo_screen.dart';
import '../presentation/screens/teacher/class/editclass/editclass_screen.dart';
import '../presentation/screens/teacher/class/exportcsv/exportcsvscreen.dart';
import '../presentation/screens/teacher/class/exportcsv/widget/gpahomelistexport.dart';
import '../presentation/screens/teacher/class/exportcsv/widget/gpalistexport.dart';
import '../presentation/screens/teacher/class/exportcsv/widget/scorelistexport.dart';
import '../presentation/screens/teacher/classselect/addclass/addclass_screen.dart';
import '../presentation/screens/teacher/classselect/classselect_screen.dart';
import '../presentation/screens/teacher/help/help_screen.dart';
import '../presentation/screens/teacher/news/addnews/addnews_screen.dart';
import '../presentation/screens/teacher/news/comment/comment_screen.dart';
import '../presentation/screens/teacher/news/likes/likes_screen.dart';
import '../presentation/screens/teacher/notification/classnotification_screen.dart';
import '../presentation/screens/teacher/schedule/scheduleadd/scheduleadd_screen.dart';
import '../presentation/screens/teacher/scorestudent/gpa/editgpa/editgpabad_form.dart';
import '../presentation/screens/teacher/scorestudent/gpa/editgpa/editgpagood_form.dart';
import '../presentation/screens/teacher/scorestudent/gpa/editgpa_screen.dart';
import '../presentation/screens/teacher/scorestudent/gpa/gpaadd_screen.dart';
import '../presentation/screens/teacher/scorestudent/score/editscore/scoredetail_editscreen.dart';
import '../presentation/screens/teacher/scorestudent/score/score_editscreen.dart';
import '../presentation/screens/teacher/scorestudent/score/scoreadd_screen.dart';
import '../presentation/screens/teacher/scorestudent/scorestudent_screen.dart';
import '../presentation/screens/teacher/scorestudent/statistic/gpa_home_statistic/gpa_home_statistic_screen.dart';
import '../presentation/screens/teacher/scorestudent/statistic/statistic_screen.dart';
import '../presentation/screens/teacher/student/addstudent/addstudent_screen.dart';
import '../presentation/screens/parent/news/sons/addsons/addsons_screen.dart';
import '../presentation/screens/teacher/student/editstudent/editstudent_screen.dart';
import '../presentation/screens/teacher/student/roll-call/export/rollcallexport.dart';
import '../presentation/screens/teacher/student/roll-call/roll-call_screen.dart';
class AppRouter{
  static const String SPLASH ='/splash';
  static const String CLASSSELECT = '/classselect';
  static const String LOGIN = '/login';
  static const String HOMETEACHER = '/hometeacher';
  static const String SIGNUP = '/signup';
  static const String PROFILE = '/profile';
  static const String ADDCLASS = '/addclass';
  static const String ADDNEWS = '/addnews';
  static const String ADDSTUDENT = '/addstudent';
  static const String SCORESTUDENT = '/scorestudent';
  static const String COMMENT ='/comment';
  static const String SCHEDULEADD ='/scheduleadd';
  static const String SCHEDULEADD2 ='/scheduleadd2';
  static const String ROLESELECT = '/roleselect';
  static const String ADDGPA = '/addgpa';
  static const String ADDSCORE = '/addscore';
  static const String CHATINFO = '/chatinfo';
  static const String CHATADD = '/chatadd';
  static const String HOMEPARENT ='/homeparent';
  static const String ADDSCREEN ='/addscreen';
  static const String CHANGEPASSWORD ='/changepassword';
  static const String JOINCLASS ='/joinclass';
  static const String ADDSON ='/addson';
  static const String SONINFOR ='/soninfor';
  static const String ADDGPASON ='/addgpason';
  static const String CONNECTSON ='/connectson';
  static const String REQUESTTOCLASS ='/requesttoclass';
  static const String ADDREQUEST ='/addrequest';
  static const String ROLLCALL ='/rollcall';
  static const String EXPORTCSV ='/exportcsv';
  static const String STATISTIC ='/statistic';
  static const String HOMESTATISTIC ='/homestatistic';
  static const String HELP ='/help';
  static const String LIKES ='/likes';
  static const String NOTIFICATION ='/notification';
  static const String CLASSNOTIFICATION ='/classnotification';
  static const String SCORELISTEXPORT ='/scorelistexport';
  static const String ROLLCALLLISTEXPORT ='/rollcalllistexport';
  static const String GPALISTEXPORT ='/gpalistexport';
  static const String GPAHOMELISTEXPORT ='/gpahomelistexport';
  static const String SONCALENDAR ='/soncalendar';
  static const String EDITCLASS ='/editclass';
  static const String EDITSTUDENT ='/editstudent';
  static const String EDITGPAGOOD ='/editgpagood';
  static const String EDITGPABAD ='/editgpabad';
  static const String EDITGPA ='/editgpa';
  static const String EDITSCOREDETAIL='/editscoretail';
  static const String EDITSCORESCREEN='/editscorescreen';
  static const String GROUPCHATSCREEN='/groupchatscreen';
  static const String EDITSONGPAGOOD ='/editsongpagood';
  static const String EDITSONGPABAD ='/editsongpabad';
  static const String EDITSONGPA ='/editsongpa';
  static const String GPASONSTATISTIC ='/gpasonstatistic';
  static const String COMMENTPARENT ='/commentparent';


  static Route<dynamic> router(RouteSettings routerSetting)
  {
    switch(routerSetting.name){
      case SPLASH:
        return MaterialPageRoute(builder: (context) => SplashScreen(),);
      case LOGIN:
        return MaterialPageRoute(builder: (context) => LoginScreen(),);
      case CLASSSELECT:
        return MaterialPageRoute(builder: (context) => ClassSelectScreen(),);
      case HOMETEACHER:
        var className = routerSetting.arguments as ClassModel;
        return MaterialPageRoute(builder: (context) => HomeTeacher(classModel: className),);
      case SIGNUP:
        bool teacherRole = routerSetting.arguments as bool;
        return MaterialPageRoute(builder: (context) => SignUpTeacherScreen(teacher: teacherRole),);
      case ADDCLASS:
        return MaterialPageRoute(builder: (context) => AddClassScreen(),);
      case ADDSTUDENT:
        return MaterialPageRoute(builder: (context) => AddStudentScreen(),);
      case SCORESTUDENT:
        List list = routerSetting.arguments as List;
        return MaterialPageRoute(builder: (context) => ScoreStudentScreen(studentModel: list[0],classModel: list[1]),);
      case ADDNEWS:
        return MaterialPageRoute(builder: (context) => AddNewsScreen(),);
      case COMMENT:
        var newModel = routerSetting.arguments as NewsModel;
        return MaterialPageRoute(builder: (context) => CommentScreen(newModel: newModel),);
      case COMMENTPARENT:
        var newModel = routerSetting.arguments as NewsModel;
        return MaterialPageRoute(builder: (context) => CommentScreenParent(newModel: newModel),);
      case SCHEDULEADD:
        var scheduleModel = routerSetting.arguments as ScheduleModel;
        return MaterialPageRoute(builder: (context) => ScheduleAddScreen(scheduleModel: scheduleModel,));
      case SCHEDULEADD2:
        return MaterialPageRoute(builder: (context) => ScheduleAddScreen());
      case ROLESELECT:
        return MaterialPageRoute(builder: (context) => SelectAccountScreen());
      case ADDGPA:
        var GoodOrBad = routerSetting.arguments as String;
        return MaterialPageRoute(builder: (context) => GpaAddScreen(GoodOrBad: GoodOrBad));
      case ADDSCORE:
        return MaterialPageRoute(builder: (context) => ScoreAddScreen());
      case CHATINFO:
        List usermodelList = routerSetting.arguments as List;
        return MaterialPageRoute(builder: (context) => ChatInfoScreen(currentModel: usermodelList[0],otherModel: usermodelList[1],));
      case CHATADD:
        return MaterialPageRoute(builder: (context) => ChatsAddScreen());
      case HOMEPARENT:
        return MaterialPageRoute(builder: (context) => HomeParent());
      case ADDSCREEN:
        var classModel = routerSetting.arguments as ClassModel;
        return MaterialPageRoute(builder: (context) => AddScreen(classModel: classModel,));
      case CHANGEPASSWORD:
        return MaterialPageRoute(builder: (context) => ChangePasswordScreen());
      case JOINCLASS:
        return MaterialPageRoute(builder: (context) => JoinClassScreen());
      case ADDSON:
        return MaterialPageRoute(builder: (context) => AddSonsScreen());
      case SONINFOR:
        var studentModel = routerSetting.arguments as StudentModel;
        return MaterialPageRoute(builder: (context) => SonInformation(studentModel: studentModel));
      case ADDGPASON:
        var GoodOrBad = routerSetting.arguments as String;
        return MaterialPageRoute(builder: (context) => GpaSonAddForm(GoodOrBad: GoodOrBad));
      case CONNECTSON:
        var studentModel = routerSetting.arguments as StudentModel;
        return MaterialPageRoute(builder: (context) => ConnectSonScreen(studentModel: studentModel,));
      case REQUESTTOCLASS:
        var studentModel = routerSetting.arguments as StudentModel;
        return MaterialPageRoute(builder: (context) => RequestToClassScreen(studentModel: studentModel,));
      case ADDREQUEST:
        List list = routerSetting.arguments as List;
        return MaterialPageRoute(builder: (context) => AddRequestScreen(studentModel: list[0],name: list[1],));
      case ROLLCALL:
        return MaterialPageRoute(builder: (context) => RollCallScreen());
      case EXPORTCSV:
        return MaterialPageRoute(builder: (context) => ExportCsvScreen());
      case STATISTIC:
        var studentModel = routerSetting.arguments as StudentModel;
        return MaterialPageRoute(builder: (context) => StatisticScreen(studentModel: studentModel));
      case HOMESTATISTIC:
        var studentModel = routerSetting.arguments as StudentModel;
        return MaterialPageRoute(builder: (context) => GpaHomeStatisticScreen(studentModel: studentModel));
      case HELP:
        return MaterialPageRoute(builder: (context) => HelpScreen());
      case LIKES:
        var newsModel = routerSetting.arguments as NewsModel;
        return MaterialPageRoute(builder: (context) => LikesScreen(newsModel: newsModel));
      case NOTIFICATION:
        return MaterialPageRoute(builder: (context) => NotificationScreen());
      case CLASSNOTIFICATION:
        return MaterialPageRoute(builder: (context) => ClassNotificationScreen());
      case SCORELISTEXPORT:
        var classId = routerSetting.arguments as String;
        return MaterialPageRoute(builder: (context) => ScoreListExport(classId: classId));
      case ROLLCALLLISTEXPORT:
        var classId = routerSetting.arguments as String;
        return MaterialPageRoute(builder: (context) => RollCallExport(classId: classId));
      case GPALISTEXPORT:
        var classId = routerSetting.arguments as String;
        return MaterialPageRoute(builder: (context) => GpaListExport(classId: classId));
      case GPAHOMELISTEXPORT:
        var classId = routerSetting.arguments as String;
        return MaterialPageRoute(builder: (context) => GpaHomeListExport(classId: classId));
      case SONCALENDAR:
        var classId = routerSetting.arguments as String;
        return MaterialPageRoute(builder: (context) => CalendarScreen(classId: classId,));
      case EDITCLASS:
        var classModel = routerSetting.arguments as ClassModel;
        return MaterialPageRoute(builder: (context) => EditClassScreen(classModel: classModel,));
      case EDITSTUDENT:
        List list = routerSetting.arguments as List;
        return MaterialPageRoute(builder: (context) => EditStudentScreen(studentModel: list[0],sonOrStudent: list[1],));
      case EDITGPAGOOD:
        return MaterialPageRoute(builder: (context) => EditGpaGoodForm());
      case EDITGPABAD:
        return MaterialPageRoute(builder: (context) => EditGpaBadForm());
      case EDITGPA:
        List list = routerSetting.arguments as List;
        return MaterialPageRoute(builder: (context) => EditGpaScreen(GoodorBad: list[0],gpaModel: list[1],));
      case EDITSCOREDETAIL:
        return MaterialPageRoute(builder: (context) => EditScoreDetailForm());
      case EDITSCORESCREEN:
        var scoreModel = routerSetting.arguments as ScoreModel;
        return MaterialPageRoute(builder: (context) => EditScoreScreen(scoreModel: scoreModel,));

      case EDITSONGPAGOOD:
        return MaterialPageRoute(builder: (context) => EditSonGpaGoodForm());
      case EDITSONGPABAD:
        return MaterialPageRoute(builder: (context) => EditSonGpaBadForm());
      case EDITSONGPA:
        List list = routerSetting.arguments as List;
        return MaterialPageRoute(builder: (context) => EditSonGpaScreen(GoodorBad: list[0],gpaModel: list[1],));
      case GPASONSTATISTIC:
        var studentModel = routerSetting.arguments as StudentModel;
        return MaterialPageRoute(builder: (context) => StatisticSonScreen(studentModel: studentModel));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routerSetting.name}'),
            ),
          ),
        );
    }
  }
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();
}

