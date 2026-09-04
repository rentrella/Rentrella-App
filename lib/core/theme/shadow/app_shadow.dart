import 'package:flutter/material.dart';

import '../color/app_colors.dart';

class AppShadow {
  AppShadow._();

  static const card = BoxShadow(
    color: AppColors.subL_3,
    blurRadius: 4,
    offset: Offset(0, 1),
    spreadRadius: 0,
  );
}
