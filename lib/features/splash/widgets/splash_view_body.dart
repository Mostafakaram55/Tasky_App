import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/config/local/cache_helper.dart';
import 'package:tasky_app/core/utils/app_assets.dart';
import 'package:tasky_app/core/utils/app_constants.dart';

import '../../../config/routes/app_routes.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    navigationToScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      height: double.infinity,
      width: double.infinity,
      image: AssetImage(AppAssets.splashImage),
      fit: BoxFit.cover,
    );
  }

  void navigationToScreen(context) {
    Future.delayed(const Duration(seconds:5)).then((value) async {
      bool isOnBoardingVisited =
          await CacheHelper.getData(key: 'isOnBoardingVisited') ?? false;
      if (isOnBoardingVisited == true) {
        if (AppConstants.accessToken.isNotEmpty) {
          GoRouter.of(context).go(AppRouter.kHomeView);
        } else {
          GoRouter.of(context).go(AppRouter.kSignInView);
        }
      } else {
        GoRouter.of(context).go(AppRouter.kOnBoardingView);
      }
    });
  }
}
