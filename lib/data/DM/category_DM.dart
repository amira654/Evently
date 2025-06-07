import 'package:flutter/cupertino.dart';

class CategoryDM {
  final String id;
  final String? imagePath;
  final IconData icon;
  final String categoryName;

  const CategoryDM(
      {required this.id,
      this.imagePath,
      required this.icon,
      required this.categoryName});
}
