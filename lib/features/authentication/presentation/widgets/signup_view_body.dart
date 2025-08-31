
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky_app/features/authentication/presentation/cubits/register_cubit/register_state.dart';
import 'package:tasky_app/features/authentication/presentation/widgets/have_email_widget.dart';
import 'package:tasky_app/features/authentication/presentation/widgets/signUp_text_fileds_section.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../config/local/cache_helper.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_constants.dart';
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
    return BlocConsumer<SignUPCubit,SignUpStates>(
      listener: (context,state){
        if(state is SuccessSignUpState){
          CacheHelper.saveData(key: 'access_token', value: state.userData.accessToken);
          CacheHelper.saveData(
            key: 'refresh_token',
            value: state.userData.refreshToken,
          );
          AppConstants.accessToken=state.userData.accessToken;
          AppConstants.refreshToken=state.userData.refreshToken;
          context.go(AppRouter.kHomeView);
          customSnackBar(
            context,
            CustomSnackBar.success(message:TextManager.signUpSuccessful),
          );
        }else if(state is ErrorSignUpState){
          customSnackBar(
            context,
            CustomSnackBar.error(message: state.message),
          );
        }
      },
      builder: (context,state){
        return ModalProgressHUD(
          inAsyncCall: state is LoadingSignUpState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator:  const CircularProgressIndicator(),
          child: SafeArea(
            child: Form(
              key: context.read<SignUPCubit>().formRegisterKey,
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
          ),
        );
      },
    );
  }
}