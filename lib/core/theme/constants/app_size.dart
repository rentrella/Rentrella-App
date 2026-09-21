import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  AppSize._();

  static double get s2 => 2.r;

  static double get s4 => 4.r;

  static double get s6 => 6.r;

  static double get s8 => 8.r;

  static double get s12 => 12.r;

  static double get s16 => 16.r;

  static double get s18 => 18.r;

  static double get s20 => 20.r;

  static double get s24 => 24.r;

  static double get s28 => 28.r;

  static double get s32 => 32.r;

  static double get s36 => 36.r;

  static double get s38 => 38.r;

  static double get s40 => 40.r;

  static double get s44 => 44.r;

  static double get s48 => 48.r;

  static double get s52 => 52.r;

  static double get s56 => 56.r;

  static double get s60 => 60.r;

  static double get s64 => 64.r;

  static double get s68 => 68.r;

  static double get s80 => 80.r;

  static double get s88 => 88.r;

  static double get s100 => 100.r;

  static double get s120 => 120.r;

  static double get s160 => 160.r;

  static double get s180 => 180.r;
}

extension QuickGap on double {
  SizedBox get gapW => SizedBox(width: this);

  SizedBox get gapH => SizedBox(height: this);
}
