import 'package:evently_app/presentation/create_event/create_event.dart';
import 'package:evently_app/presentation/create_event/selected_location.dart';
import 'package:evently_app/presentation/event_details/event_details.dart';
import 'package:evently_app/presentation/main_layout/main_layout.dart';
import 'package:evently_app/presentation/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';

import '../../data/DM/event_DM.dart';
import '../../presentation/autentication/reset_password/reset_password_view.dart';
import '../../presentation/autentication/signIn/signIn.dart';
import '../../presentation/autentication/signUp/signUp.dart';

class RoutesManager {
  static const String signUp = "/signUp";
  static const String signIn = "/signIn";
  static const String mainLayout = "/mainLayout";
  static const String createEvent = "/createEvent";
  static const String selectedLocation = "/selectedLocation";
  static const String onBoarding = "/onBoarding";
  static const String eventDetails = "/eventDetails";
  static const String resetPassword = "/resetPassword";

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
          settings: settings,
          builder: (context) => CreateEventScreen(
            event: settings.arguments as EventDM?,
          ),
        );
      case selectedLocation:
        return CupertinoPageRoute(
          builder: (context) => const SelectedLocation(),
        );
      case onBoarding:
        return CupertinoPageRoute(
          builder: (context) =>  OnBoarding(),
        );
      case eventDetails:
        return CupertinoPageRoute(
          settings: settings,
          builder: (context) => EventDetailsView(
            event: settings.arguments as EventDM,
          ),
        );
      case resetPassword:
        return CupertinoPageRoute(
          builder: (context) => const ResetPasswordView(),
        );
    }
  }
}
