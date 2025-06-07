import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../data/DM/category_DM.dart';

class ConstantManager {
  static const String weakPassword = 'weak-password';
  static const String emailInUse = 'email-already-in-use';
  static const String invalidCredential = "invalid-credential";
  static List<CategoryDM> categories = const [
    CategoryDM(
        id: "1",
        categoryName: "Sport",
        icon: Icons.sports_gymnastics_rounded,
        imagePath: ImageAssets.sports),
    CategoryDM(
        id: "2",
        categoryName: "BirthDay",
        icon: Icons.cake_rounded,
        imagePath: ImageAssets.birthday),
    CategoryDM(
        id: "3",
        categoryName: "Meeting",
        icon: Icons.laptop_mac_rounded,
        imagePath: ImageAssets.meeting),
    CategoryDM(
        id: "4",
        categoryName: "Gaming",
        icon: Icons.games_rounded,
        imagePath: ImageAssets.gaming),
    CategoryDM(
        id: "5",
        categoryName: "Eating",
        icon: Icons.fastfood_rounded,
        imagePath: ImageAssets.eating),
    CategoryDM(
        id: "6",
        categoryName: "Holiday",
        icon: Icons.holiday_village_rounded,
        imagePath: ImageAssets.holiday),
    CategoryDM(
        id: "7",
        categoryName: "Exhibition",
        icon: Icons.water_drop_outlined,
        imagePath: ImageAssets.exhibition),
    CategoryDM(
        id: "8",
        categoryName: "WorkShop",
        icon: Icons.workspaces_outlined,
        imagePath: ImageAssets.workshop)
  ];

  static List<CategoryDM> categoriesWithAll = const [
    CategoryDM(id: "0", categoryName: "All", icon: Icons.grid_3x3),
    CategoryDM(
        id: "1", categoryName: "Sport", icon: Icons.sports_gymnastics_rounded),
    CategoryDM(id: "2", categoryName: "BirthDay", icon: Icons.cake_rounded),
    CategoryDM(
        id: "3", categoryName: "Meeting", icon: Icons.laptop_mac_rounded),
    CategoryDM(id: "4", categoryName: "Gaming", icon: Icons.games_rounded),
    CategoryDM(id: "5", categoryName: "Eating", icon: Icons.fastfood_rounded),
    CategoryDM(
        id: "6", categoryName: "Holiday", icon: Icons.holiday_village_rounded),
    CategoryDM(
        id: "7", categoryName: "Exhibition", icon: Icons.water_drop_outlined),
    CategoryDM(
        id: "8", categoryName: "WorkShop", icon: Icons.workspaces_outlined)
  ];
}
