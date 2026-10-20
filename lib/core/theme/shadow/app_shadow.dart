import 'package:flutter/material.dart';

import '../color/app_colors.dart';

class AppShadow {
  AppShadow._();

  static const button = BoxShadow(
    color: AppColors.subL_3,
    blurRadius: 4,
    offset: Offset(0, 1),
    spreadRadius: 0,
  );

  static const soft = BoxShadow(
    color: AppColors.subL_3,
    blurRadius: 2,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  static const card = BoxShadow(
    color: AppColors.subL_3,
    blurRadius: 4,
    offset: Offset(0, 1),
    spreadRadius: 0,
  );

  static const field = BoxShadow(
    color: AppColors.subL_3,
    blurRadius: 4,
    offset: Offset(0, 3),
    spreadRadius: 0,
  );
}
