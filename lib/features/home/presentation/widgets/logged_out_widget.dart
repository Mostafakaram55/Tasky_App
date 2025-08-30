
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_app/core/utils/app_colors.dart';

import '../../../../config/icons/icons_broken.dart';
import '../../../../config/local/cache_helper.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/widgets/custom_icon_button.dart';

class LoggedOutWidget extends StatelessWidget {
  const LoggedOutWidget({super.key, required this.operation,  required this.icon});
final void Function() operation;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: ColorManager.buttonColor,
      child: CustomIconButton(iconBroken: icon, operation: (){
        operation();
      }, colorIcon: Colors.white,
      ),
    );
  }
}
