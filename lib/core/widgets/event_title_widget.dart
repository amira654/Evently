import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors_manager.dart';

class EventTitleWidget extends StatelessWidget {
  const EventTitleWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: REdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
            )),
            const Icon(
              Icons.favorite,
              color: ColorsManager.blue,
            ),
          ],
        ),
      ),
    );
  }
}
