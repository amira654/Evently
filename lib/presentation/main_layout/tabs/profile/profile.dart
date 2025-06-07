import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_drop_down_menu.dart';
import 'package:evently_app/core/widgets/custom_profile_header.dart';
import 'package:evently_app/data/DM/userDM.dart';
import 'package:evently_app/data/firebase_service/firebase_service.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedLanguage = "English";
  late ConfigProvider configProvider;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      children: [
        CustomProfileHeader(
          userName: UserDM.currentUser!.name,
          userEmail: UserDM.currentUser!.email,
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDropDownMenu(
                title: AppLocalizations.of(context)!.language,
                textView: configProvider.isEnglish ? "English" : "عربي",
                menuItems: const ["English", "عربي"],
                onChange: _onLanguageChange,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomDropDownMenu(
                  title: AppLocalizations.of(context)!.theme,
                  textView: configProvider.isDark
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
                  menuItems: [
                    AppLocalizations.of(context)!.light,
                    AppLocalizations.of(context)!.dark
                  ],
                  onChange: _onThemeChange)
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding:
              const EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 25),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r)),
                  backgroundColor: ColorsManager.red,
                  padding: REdgeInsets.symmetric(vertical: 12),
                  foregroundColor: ColorsManager.white,
                  textStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.white)),
              onPressed: () async {
              await  FirebaseServices.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutesManager.signIn, (route) => false);
              },
              child: Row(
                children: [
                  const Icon(Icons.login_rounded),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(AppLocalizations.of(context)!.logout),
                ],
              )),
        )
      ],
    );
  }

  void _onLanguageChange(String? newLang) {
    String lang = newLang == "English" ? "en" : "ar";
    configProvider.changeAppLang(lang);
  }

  void _onThemeChange(String? newTheme) {
    ThemeMode theme = newTheme == AppLocalizations.of(context)!.light
        ? ThemeMode.light
        : ThemeMode.dark;
    configProvider.changeAppTheme(theme);
  }

}
