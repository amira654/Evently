import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/custom_text_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool securePassword = true;
  bool secureRePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.sign_up),
      ),
      body: Column(
        children: [
          Expanded(child: Image.asset(ImageAssets.logo)),
          Expanded(
            flex: 4,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      keyboardType: TextInputType.name,
                      label: AppLocalizations.of(context)!.name,
                      prefixIcon: Icons.person,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      label: AppLocalizations.of(context)!.email,
                      prefixIcon: Icons.email_rounded,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      label: AppLocalizations.of(context)!.password,
                      prefixIcon: Icons.lock,
                      suffixIcon: securePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      isSecure: securePassword,
                      onPress: _onPasswordIconClick,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      label: AppLocalizations.of(context)!.re_password,
                      prefixIcon: Icons.lock,
                      suffixIcon: secureRePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      isSecure: secureRePassword,
                      onPress: _onRePasswordIconClick,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomElevatedButton(
                        title: AppLocalizations.of(context)!.sign_up,
                        onPress: () {}),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.already_have_account,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        CustomTextButton(
                            title: AppLocalizations.of(context)!.sign_in,
                            onPress: () {})
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onPasswordIconClick() {
    securePassword = !securePassword;
    setState(() {});
  }

  void _onRePasswordIconClick() {
    secureRePassword = !secureRePassword;
    setState(() {});
  }
}
