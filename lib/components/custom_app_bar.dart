import 'package:flutter/material.dart';
import 'package:swivt_assignment/app/theme/app_colors.dart';
import 'package:swivt_assignment/app/theme/app_styles.dart';

AppBar buildCustomAppBar({required String pageTitle}) => AppBar(
      backgroundColor: AppColors.appWhite,
      centerTitle: true,
      title: Text(
        pageTitle,
        style:
            AppStyle.semiBoldText16.copyWith(color: AppColors.darkBlueShade2),
      ),
    );
