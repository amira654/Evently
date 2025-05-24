import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/colors_manager.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
      useMaterial3: false,
      iconTheme: const IconThemeData(
        color: ColorsManager.black,
      ),
      cardColor: ColorsManager.light,
      cardTheme: CardTheme(
        color: ColorsManager.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.blue,
          foregroundColor: ColorsManager.white,
          shape: StadiumBorder(
              side: BorderSide(
            width: 4.w,
            color: ColorsManager.white,
          ))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.white,
        unselectedItemColor: ColorsManager.white,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: ColorsManager.blue,
        shape: CircularNotchedRectangle(),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorsManager.light,
        foregroundColor: ColorsManager.black10,
        iconTheme: const IconThemeData(
          color: ColorsManager.blue,
        ),
        titleTextStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            color: ColorsManager.blue),
      ),
      primaryColor: ColorsManager.blue,
      scaffoldBackgroundColor: ColorsManager.light,
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: ColorsManager.grey,
        suffixIconColor: ColorsManager.grey,
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.sp,
          color: ColorsManager.grey,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.sp,
          color: ColorsManager.grey,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: ColorsManager.blue,
              textStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: ColorsManager.blue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              backgroundColor: ColorsManager.blue,
              padding: REdgeInsets.symmetric(vertical: 12),
              foregroundColor: ColorsManager.white,
              textStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.white))),
      textTheme: TextTheme(
        bodySmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.black1C),
        titleMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.blue),
        titleSmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: ColorsManager.white),
        headlineMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white),
        headlineSmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.white),
        titleLarge: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white),
        labelMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.blue),
        labelSmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.black1C),
        displayMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.black1C),
        displaySmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.blue),
      ));
  static final ThemeData dark = ThemeData(
      useMaterial3: false,
      iconTheme: const IconThemeData(
        color: ColorsManager.blue,
      ),
      cardColor: ColorsManager.black10,
      cardTheme: CardTheme(
        color: ColorsManager.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ColorsManager.black10,
          foregroundColor: ColorsManager.ofWhite,
          shape: StadiumBorder(
              side: BorderSide(
            width: 4.w,
            color: ColorsManager.ofWhite,
          ))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsManager.ofWhite,
        unselectedItemColor: ColorsManager.ofWhite,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: ColorsManager.black10,
        shape: CircularNotchedRectangle(),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorsManager.black10,
        foregroundColor: ColorsManager.blue,
        iconTheme: const IconThemeData(
          color: ColorsManager.blue,
        ),
        titleTextStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            color: ColorsManager.blue),
      ),
      primaryColor: ColorsManager.dark,
      scaffoldBackgroundColor: ColorsManager.dark,
      inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: ColorsManager.ofWhite,
        suffixIconColor: ColorsManager.ofWhite,
        labelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.sp,
          color: ColorsManager.ofWhite,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.sp,
          color: ColorsManager.ofWhite,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: ColorsManager.red, width: 1.w),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: ColorsManager.blue,
              textStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: ColorsManager.blue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  decoration: TextDecoration.underline))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              backgroundColor: ColorsManager.blue,
              padding: REdgeInsets.symmetric(vertical: 12),
              foregroundColor: ColorsManager.white,
              textStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorsManager.white))),
      textTheme: TextTheme(
        bodySmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.ofWhite),
        titleMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.ofWhite),
        titleSmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: ColorsManager.ofWhite),
        headlineMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.white),
        headlineSmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.white),
        titleLarge: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.ofWhite),
        labelMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.blue),
        labelSmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.ofWhite),
        displayMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.ofWhite),
        displaySmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.blue),
      ));
}
