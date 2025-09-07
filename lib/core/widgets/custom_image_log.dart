import 'package:flutter/material.dart';
import 'package:tasky_app/core/utils/app_assets.dart';

class CustomImageLogo extends StatelessWidget {
  const CustomImageLogo({super.key,});

  @override
  Widget build(BuildContext context) {
    return  AspectRatio(
      aspectRatio: 0.958,
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage(AppAssets.authImage),
      ),
    );
  }
}