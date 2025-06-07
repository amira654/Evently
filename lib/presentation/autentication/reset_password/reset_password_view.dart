import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../../data/firebase_service/firebase_service.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(ImageAssets.resetPassword),
              SizedBox(
                height: 24.h,
              ),
              CustomTextFormField(
                controller: _emailController,
                label:  'Email',
                prefixIcon: Icons.email,
              ), SizedBox(
                height: 15.h,
              ),
              CustomElevatedButton(
                title: 'Reset Password',
                onPress: () {
                  final email = _emailController.text.trim();
                  if(email.isNotEmpty){
                    FirebaseServices.resetPassword(email).then((value) {
                      Navigator.pop(context);
                    });
                  }
                },)
            ],
          ),
        ),
      ),
    );
  }
}
