
import 'package:flutter/material.dart';
import 'package:tasky_app/features/onboarding/widgets/on_boarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingViewBody(),
    )  ;
  }
}