import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'event_date_widget.dart';
import 'event_title_widget.dart';

class CustomEvent extends StatelessWidget {
  const CustomEvent({super.key, required this.event, required this.favEvent});

  final EventDM event;
  final bool favEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.all(16),
      width: 250.w,
      height: 203.h,
      decoration: BoxDecoration(
          border: Border.all(color: ColorsManager.blue, width: 1),
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
                event.category.imagePath ?? "assets/images/sports.jpg"),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventDateWidget(
            date: event.dateTime,
          ),
          const Spacer(),
          EventTitleWidget(event: event, favEvent: favEvent),
        ],
      ),
    );
  }
}
