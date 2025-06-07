import 'package:evently_app/core/extensions/text_extention.dart';
import 'package:evently_app/core/resources/constant_manager.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/data/firebase_service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/routes_manager/routes_manager.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_divider.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../core/widgets/custom_text_button.dart';
import '../../../core/widgets/custom_text_form_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool secure = true;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(child: Image.asset(ImageAssets.logo)),
              Expanded(
                flex: 4,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomTextFormField(
                            controller: emailController,
                            validator: (input) {
                              if (input == null || input.trim().isEmpty) {
                                return "Plz, enter email";
                              }
                              if (!input.isValidEmail) {
                                return "Email bad format";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            label: AppLocalizations.of(context)!.email,
                            prefixIcon: Icons.email_rounded),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          validator: (input) {
                            if (input == null || input.trim().isEmpty) {
                              return "Plz, enter password";
                            }
                            if (input.length < 6) {
                              return "sorry, password should be 6 character";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          isSecure: secure,
                          label: AppLocalizations.of(context)!.password,
                          prefixIcon: Icons.lock,
                          suffixIcon:
                              secure ? Icons.visibility_off : Icons.visibility,
                          onPress: _onClick,
                        ),
                        CustomTextButton(
                            title:
                                AppLocalizations.of(context)!.forget_password,
                            onPress: () {
                              Navigator.pushNamed(
                                  context, RoutesManager.resetPassword);
                            }),
                        CustomElevatedButton(
                            title: AppLocalizations.of(context)!.sign_in,
                            onPress: _signIn),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.dont_have_account,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomTextButton(
                                title: AppLocalizations.of(context)!
                                    .create_account,
                                onPress: () {
                                  Navigator.pushReplacementNamed(
                                      context, RoutesManager.signUp);
                                })
                          ],
                        ),
                        CustomDivider(title: AppLocalizations.of(context)!.or),
                        SizedBox(
                          height: 32.h,
                        ),
                        CustomButton(
                            title:
                                AppLocalizations.of(context)!.login_with_google,
                            onTap: () {
                              _signInWithGoogle();
                            })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onClick() {
    setState(() {
      secure = !secure;
    });
  }

  void _signIn() async {
    if (!formKey.currentState!.validate()) return;

    try {
      DialogUtils.showLoadingDialog(context);
      await FirebaseServices.signIn(
          emailController.text, passwordController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context, "User Logged-In Successfully",
          posTitle: "Go", posAction: () {
        Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
      });
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == ConstantManager.invalidCredential) {
        DialogUtils.showMessageDialog(context, "Wrong email or password",
            posTitle: "retry");
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context, e.toString(), posTitle: "retry");
    }
  }

  _signInWithGoogle() async {
    try {
      await FirebaseServices.loginWithGoogle();
      DialogUtils.showMessageDialog(context, "User Logged-In Successfully",
          posTitle: "Go", posAction: () {
        Navigator.pushReplacementNamed(
          context,
          RoutesManager.mainLayout,
        );
      });
    } catch (e) {
      DialogUtils.showMessageDialog(
        context,
        "Wrong email or password",
        posTitle: "retry",
      );
    }
  }
}
