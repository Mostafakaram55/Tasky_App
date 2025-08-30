import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../config/local/cache_helper.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_image_log.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';
import '../../../../core/widgets/custom_text_filed_phone.dart';
import '../../../../core/widgets/custom_text_widget.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../cubits/login_cubit/login_state.dart';
import 'have_email_widget.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state) {
        if (state is SuccessSignInState) {
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
          customSnackBar(
            context,
            CustomSnackBar.success(message: 'Good job, your release is successful. Have a nice day'),
          );
          GoRouter.of(context).go(AppRouter.kHomeView);
        } else if (state is ErrorSignInState) {
          customSnackBar(
            context,
            CustomSnackBar.error(message: state.message),
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
                  padding: EdgeInsets.all(12.r),
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
                        TextFormFiledPhone(
                          phoneController:
                          context.read<SignInCubit>().phoneController,
                          onChanged: (PhoneNumber phone) {
                            context.read<SignInCubit>().changeSelectedPhoneNumber(
                              phoneNumber: phone,
                            );
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormFiled(
                          widgetIconPrefix: Icon(Icons.lock),
                          widgetIconsuffix: IconButton(
                            onPressed: () {
                              context.read<SignInCubit>().changeVisiblePassword();
                            },
                            icon:
                            context.read<SignInCubit>().isVisiblePassword
                                ? Icon(Icons.visibility_off, size: 20.sp)
                                : Icon(Icons.visibility, size: 20.sp),
                          ),
                          hintText: 'Password',
                          obscureText:
                          context.read<SignInCubit>().isVisiblePassword,
                          textEditingController:
                          SignInCubit.get(context).passwordController,
                          textInputType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.h),
                        CustomButton(
                          onPressed: () {
                            if (SignInCubit.get(context,).formLoginKey.currentState!.validate()) {
                              if (context
                                  .read<SignInCubit>()
                                  .phoneController
                                  .text
                                  .isNotEmpty) {
                                SignInCubit.get(context).signIn();
                              } else {
                                customSnackBar(
                                  context,
                                  CustomSnackBar.error(message:'please enter  phone '),
                                );
                              }
                            }
                          },
                          titleButton: TextManager.logIn,
                        ),
                        HaveEmailOrNot(
                          operation: () {
                            context.push(AppRouter.kSignUpView);
                          },
                          operationName: "Didn’t have any account?",
                          titleButton: 'Sign Up here',
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
