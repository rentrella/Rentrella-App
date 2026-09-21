import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static const fontFamily = 'NotoSans';

  /// H
  static TextStyle get h1 => TextStyle(
    color: AppColors.mainText,
    fontSize: 36.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: fontFamily,
  );

  /// Title
  static TextStyle get title1 => TextStyle(
    color: AppColors.mainText,
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: fontFamily,
  );
  static TextStyle get title2 => TextStyle(
    color: AppColors.mainText,
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: fontFamily,
  );
  static TextStyle get title3 => TextStyle(
    color: AppColors.mainText,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    fontFamily: fontFamily,
  );

  /// Body
  static TextStyle get body1 => TextStyle(
    color: AppColors.mainText,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    fontFamily: fontFamily,
  );
  static TextStyle get body2 => TextStyle(
    color: AppColors.mainText,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    fontFamily: fontFamily,
  );
  static TextStyle get body3 => TextStyle(
    color: AppColors.mainText,
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
    fontFamily: fontFamily,
  );
  static TextStyle get body4 => TextStyle(
    color: AppColors.mainText,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontFamily: fontFamily,
  );

  /// Caption
  static TextStyle get caption1 => TextStyle(
    color: AppColors.mainText,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: fontFamily,
  );
  static TextStyle get caption2 => TextStyle(
    color: AppColors.mainText,
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: fontFamily,
  );
  static TextStyle get caption3 => TextStyle(
    color: AppColors.mainText,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    fontFamily: fontFamily,
  );

  /// Content
  static TextStyle get content1 => TextStyle(
    color: AppColors.mainText,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    fontFamily: fontFamily,
  );
  static TextStyle get content2 => TextStyle(
    color: AppColors.mainText,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
    fontFamily: fontFamily,
  );
  static TextStyle get content3 => TextStyle(
    color: AppColors.mainText,
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontFamily: fontFamily,
  );
  static TextStyle get content4 => TextStyle(
    color: AppColors.mainText,
    fontSize: 9.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
    fontFamily: fontFamily,
  );
  static TextStyle get content5 => TextStyle(
    color: AppColors.mainText,
    fontSize: 7.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
    fontFamily: fontFamily,
  );
  static TextStyle get content6 => TextStyle(
    color: AppColors.mainText,
    fontSize: 6.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontFamily: fontFamily,
  );

  /// Button
  static TextStyle get button1 => TextStyle(
    color: AppColors.mainText,
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: fontFamily,
  );

  static TextStyle get button2 => TextStyle(
    color: AppColors.mainText,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    height: 1.2,
    fontFamily: fontFamily,
  );
}
