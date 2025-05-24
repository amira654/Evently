import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/assets_manager.dart';
import '../resources/colors_manager.dart';

class CustomProfileHeader extends StatelessWidget {
  const CustomProfileHeader(
      {super.key, required this.userName, required this.userEmail});

  final String userName;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.r),
        ),
      ),
      child: Padding(
        padding: REdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(ImageAssets.profileImage),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    userEmail,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
