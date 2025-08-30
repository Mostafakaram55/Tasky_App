
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TaskDetailsQrCode extends StatelessWidget {
  const TaskDetailsQrCode({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(15.r),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: QrImageView(
            data: taskId,
            version: QrVersions.auto,
          ),
        ),
      ),
    );
  }
}