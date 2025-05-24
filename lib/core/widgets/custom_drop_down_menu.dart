import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors_manager.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.title,
    required this.textView,
    required this.menuItems,
    required this.onChange,
  });

  final String title;
  final String textView;
  final List<String> menuItems;
  final void Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(
          height: 8.h,
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(width: 1, color: ColorsManager.blue),
          ),
          child: Padding(
            padding: REdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    textView,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                  child: DropdownButton<String>(
                    style:
                        TextStyle(color: ColorsManager.blue, fontSize: 16.sp),
                    underline: Container(),
                    items: menuItems.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: onChange,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
