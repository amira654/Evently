import 'package:evently_app/data/DM/category_DM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTab extends StatelessWidget {
  const CustomTab(
      {super.key,
      required this.categoryDM,
      required this.isSelected,
      required this.selectedTabBg,
      required this.unselectedTabBg,
      required this.unselectedLabelColor,
      required this.selectedLabelColor});

  final CategoryDM categoryDM;
  final bool isSelected;
  final Color selectedTabBg;
  final Color unselectedTabBg;
  final Color unselectedLabelColor;
  final Color selectedLabelColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          color: isSelected ? selectedTabBg : unselectedTabBg,
          borderRadius: BorderRadius.circular(46.r),
          border: Border.all(width: 1, color: selectedTabBg)),
      child: Row(
        children: [
          SvgPicture.asset(
            categoryDM.iconPath,
            colorFilter: ColorFilter.mode(
              isSelected ? selectedLabelColor : unselectedLabelColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            categoryDM.categoryName,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? selectedLabelColor : unselectedLabelColor),
          ),
        ],
      ),
    );
  }
}
