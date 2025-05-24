import 'package:evently_app/core/resources/assets_manager.dart';

import '../../data/DM/category_DM.dart';

class ConstantManager {
  static const List<CategoryDM> categories = [
    CategoryDM(
        id: "0",
        imagePath: ImageAssets.sports,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "All"),
    CategoryDM(
        id: "1",
        imagePath: ImageAssets.sports,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Sports"),
    CategoryDM(
        id: "2",
        imagePath: ImageAssets.birthday,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "BirthDay"),
    CategoryDM(
        id: "3",
        imagePath: ImageAssets.meeting,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Meeting"),
    CategoryDM(
        id: "4",
        imagePath: ImageAssets.gaming,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Gaming"),
    CategoryDM(
        id: "5",
        imagePath: ImageAssets.eating,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Eating"),
    CategoryDM(
        id: "6",
        imagePath: ImageAssets.holiday,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Holiday"),
    CategoryDM(
        id: "7",
        imagePath: ImageAssets.exhibition,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Exhibition"),
    CategoryDM(
        id: "8",
        imagePath: ImageAssets.bookClub,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Workshop"),
    CategoryDM(
        id: "9",
        imagePath: ImageAssets.workshop,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "BookClub"),
  ];
  static const List<CategoryDM> categoriesWithoutAll = [
    CategoryDM(
        id: "1",
        imagePath: ImageAssets.sports,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Sports"),
    CategoryDM(
        id: "2",
        imagePath: ImageAssets.birthday,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "BirthDay"),
    CategoryDM(
        id: "3",
        imagePath: ImageAssets.meeting,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Meeting"),
    CategoryDM(
        id: "4",
        imagePath: ImageAssets.gaming,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Gaming"),
    CategoryDM(
        id: "5",
        imagePath: ImageAssets.eating,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Eating"),
    CategoryDM(
        id: "6",
        imagePath: ImageAssets.holiday,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Holiday"),
    CategoryDM(
        id: "7",
        imagePath: ImageAssets.exhibition,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Exhibition"),
    CategoryDM(
        id: "8",
        imagePath: ImageAssets.bookClub,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "Workshop"),
    CategoryDM(
        id: "9",
        imagePath: ImageAssets.workshop,
        iconPath: SvgAssets.sportsIcon,
        categoryName: "BookClub"),
  ];
}
