import 'package:flutter/material.dart';

extension BuildContextHelper on BuildContext {
  double get getScreenWidth => MediaQuery.sizeOf(this).width;

  double get getScreenHeight => MediaQuery.sizeOf(this).height;
}
