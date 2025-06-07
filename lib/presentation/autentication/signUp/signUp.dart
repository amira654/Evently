import 'package:evently_app/core/extensions/text_extention.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/constant_manager.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/data/firebase_service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController rePasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    rePasswordController.dispose();
  }

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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        controller: nameController,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return "Plz, enter name";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        label: AppLocalizations.of(context)!.name,
                        prefixIcon: Icons.person,
                      ),
                      SizedBox(
                        height: 16.h,
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
                        prefixIcon: Icons.email_rounded,
                      ),
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
                        controller: rePasswordController,
                        validator: (input) {
                          if (input == null || input.trim().isEmpty) {
                            return "Plz, enter re-password";
                          }
                          if (input != passwordController.text) {
                            return "sorry, re-password should match password";
                          }
                          return null;
                        },
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
                          onPress: _signUp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.already_have_account,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          CustomTextButton(
                              title: AppLocalizations.of(context)!.sign_in,
                              onPress: () {
                                Navigator.pushReplacementNamed(
                                    context, RoutesManager.signIn);
                              })
                        ],
                      ),
                    ],
                  ),
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

  void _signUp() async {
    if (!formKey.currentState!.validate()) return;
    try {
      DialogUtils.showLoadingDialog(context);
      await FirebaseServices.signUp(
          emailController.text, passwordController.text, nameController.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context, "User Registered Successfully",
          posTitle: "Login", posAction: () {
        Navigator.pushReplacementNamed(context, RoutesManager.signIn);
      });
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == ConstantManager.weakPassword) {
        DialogUtils.showMessageDialog(
          context,
          'The password provided is too weak.',
          posTitle: "Retry",
        );
      } else if (e.code == ConstantManager.emailInUse) {
        DialogUtils.showMessageDialog(
          context,
          'The account already exists for that email.',
          posTitle: "Retry",
        );
      }
    } catch (e) {
      DialogUtils.hideDialog(context);

      DialogUtils.showMessageDialog(
        context,
        e.toString(),
        posTitle: "Retry",
      );
    }
  }
}
