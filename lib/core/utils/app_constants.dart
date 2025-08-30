import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppConstants {
  static String accessToken ='';
  static String refreshToken='';
  static late TabController tabController;

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide.none
  );

  static final OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide.none
  );
  static final OutlineInputBorder removeBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide.none
  );

}
class SignInParam{
  final  String phone;
  final  String  password;

  SignInParam({required this.phone, required this.password});
}

class SignUpParam{
  final String phone;
  final   String password;
  final    String displayName;
  final   String experienceYears;
  final   String address;
  final  String level;

  SignUpParam({required this.phone,
    required this.password,
    required this.displayName,
    required this.experienceYears,
    required this.address,
    required this.level});

}

class UploadTaskParam{
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String dueDate;

  UploadTaskParam({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.dueDate
  });
}
class EditeTaskParam {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;
  final String idTask;

  EditeTaskParam({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.user,
    required this.status,
    required this.idTask
  });

}
