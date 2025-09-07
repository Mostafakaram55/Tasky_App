import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../config/local/cache_helper.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_image_log.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../cubits/login_cubit/login_state.dart';
import 'have_email_widget.dart';
import 'login_text_filed_scetion.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state) {
        if(state is ErrorSignInState){
          showToastificationWidget(
              message:state.message,
              context: context,
              duration: 3,
              notificationType:ToastificationType.success
          );
        } else if (state is SuccessSignInState) {
          CacheHelper.saveData(
            key: 'access_token',
            value: state.userData.accessToken,
          );
          CacheHelper.saveData(
            key: 'refresh_token',
            value: state.userData.refreshToken,
          );
          AppConstants.accessToken = state.userData.accessToken;
          AppConstants.refreshToken = state.userData.refreshToken;
          showToastificationWidget(
              message:TextManager.successfulSignIn,
              context: context,
              duration: 3,
              notificationType:ToastificationType.success
          );
           context.go(AppRouter.kHomeView
          );
        }
      },
      builder: (context, state) {
        return  ModalProgressHUD(
          inAsyncCall: state is LoadingSignInState,
          color: Colors.white,
          opacity: 0.5,
          progressIndicator:  const CircularProgressIndicator(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomImageLogo(),
                Padding(
                  padding: EdgeInsets.all(14.r),
                  child: Form(
                    key: SignInCubit.get(context).formLoginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          title: TextManager.logIn,
                          colorText: Colors.black,
                          size: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 10.h),
                        LoginTextFiledSection(),
                        CustomButton(
                          onPressed: () {
                            final cubit = SignInCubit.get(context);
                            final phone = cubit.phoneController.text.trim();
                            final password = cubit.passwordController.text.trim();

                            if (cubit.formLoginKey.currentState!.validate()) {
                              if (phone.isEmpty && password.isEmpty) {
                                showToastificationWidget(
                                    message:TextManager.errorValidatorPhoneNumberAnPassword ,
                                    context: context,

                                    notificationType:ToastificationType.error
                                );
                              } else if (phone.isEmpty) {
                                showToastificationWidget(
                                    message:TextManager.phoneErrorMessage,
                                    context: context,

                                    notificationType:ToastificationType.error
                                );

                              } else if (password.isEmpty) {
                                showToastificationWidget(
                                    message:TextManager.errorValidatorPassword,
                                    context: context,

                                    notificationType:ToastificationType.error
                                );
                              } else {
                                cubit.signIn();
                              }
                            }
                          },
                          titleButton: TextManager.logIn,
                        ),
                        HaveEmailOrNot(
                          operation: () {
                            context.push(AppRouter.kSignUpView);
                          },
                          operationName: "Did’t have any account?",
                          titleButton: TextManager.signUpHere,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
