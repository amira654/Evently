import 'package:evently_app/presentation/create_event/create_event.dart';
import 'package:evently_app/presentation/main_layout/main_layout.dart';
import 'package:flutter/cupertino.dart';

import '../../presentation/autentication/signIn/signIn.dart';
import '../../presentation/autentication/signUp/signUp.dart';

class RoutesManager {
  static const String signUp = "/signUp";
  static const String signIn = "/signIn";
  static const String mainLayout = "/mainLayout";
  static const String createEvent = "/createEvent";

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return CupertinoPageRoute(
          builder: (context) => const SignUp(),
        );
      case signIn:
        return CupertinoPageRoute(
          builder: (context) => const SignIn(),
        );
      case mainLayout:
        return CupertinoPageRoute(
          builder: (context) => const MainLayout(),
        );
      case createEvent:
        return CupertinoPageRoute(
          builder: (context) => const CreateEventScreen(),
        );
    }
  }
}
