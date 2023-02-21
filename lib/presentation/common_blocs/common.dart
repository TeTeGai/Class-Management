
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/auth/bloc.dart';

import 'application/application_bloc.dart';
import 'profile/profile_bloc.dart';

class CommonBloc {
  /// Bloc
  static final applicationBloc = ApplicationBloc();
  static final authencationBloc = AuthBloc();
  // static final languageBloc = LanguageBloc();
  // static final cartBloc = CartBloc();
  // static final orderBloc = OrderBloc();
  static final profileBloc = ProfileBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authencationBloc,
    ),
    // BlocProvider<LanguageBloc>(
    //   create: (context) => languageBloc,
    // ),
    BlocProvider<ProfileBloc>(
      create: (context) => profileBloc,
    ),
    // BlocProvider<CartBloc>(
    //   create: (context) => cartBloc,
    // ),
    // BlocProvider<OrderBloc>(
    //   create: (context) => orderBloc,
    // ),
  ];

  /// Dispose
  static void dispose() {
    applicationBloc.close();
  }

  /// Singleton factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }
  CommonBloc._internal();
}
