
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky_app/features/authentication/presentation/widgets/have_email_widget.dart';
import 'package:tasky_app/features/authentication/presentation/widgets/section_text_filed_for_signup.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../cubits/register_cubit/register_cubit.dart';


class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  AppAssets.signUpImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:  EdgeInsets.all(12.r),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SignUpSectionTextFiled(),
                        CustomButton(
                          onPressed: () {
                            if(context.read<SignUPCubit>().formRegisterKey.currentState!.validate()){
                              if(context.read<SignUPCubit>().phoneController.text.isNotEmpty){
                                context.read<SignUPCubit>().signUp();
                              }else{
                                customSnackBar(context,CustomSnackBar.error(message: 'please enter phone'));
                              }
                            }
                          },
                          titleButton: TextManager.signUp,
                        ),
                        SizedBox(height: 10.h),
                        HaveEmailOrNot(
                          operationName: TextManager.haveAccount,
                          titleButton: TextManager.logIn,
                          operation: () {
                            context.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}