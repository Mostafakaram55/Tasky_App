
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../../../../config/local/cache_helper.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/functions/show_snak_bar.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';
import '../../../../core/widgets/custom_text_filed_phone.dart';
import '../cubits/register_cubit/register_cubit.dart';
import '../cubits/register_cubit/register_state.dart';

class SignUpSectionTextFiled extends StatelessWidget {
  const SignUpSectionTextFiled({super.key});

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
          child: Form(
            key: context.read<SignUPCubit>().formRegisterKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  title: TextManager.signUp,
                  colorText: Colors.black,
                  size: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 15.h),
                CustomTextFormFiled(
                  textEditingController:  context.read<SignUPCubit>().displayNameController,
                  textInputType: TextInputType.name,
                  obscureText: false,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please enter Name ';
                    }else{
                      return null;
                    }
                  },
                  hintText: TextManager.nameText,
                  widgetIconPrefix: Icon(Icons.person),
                ),
                SizedBox(height: 15.h),
                TextFormFiledPhone(
                  onChanged: (PhoneNumber phoneNumber) {
                    context.read<SignUPCubit>().changeSelectPhoneNumber(phoneNumber: phoneNumber);
                  },
                  phoneController: context.read<SignUPCubit>().phoneController,
                ),
                SizedBox(height: 15.h),
                CustomTextFormFiled(
                  textEditingController:  context.read<SignUPCubit>().experienceYearsController,
                  textInputType: TextInputType.number,
                  obscureText: false,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please enter experience Years ';
                    }else{
                      return null;
                    }
                  },
                  hintText: TextManager.experienceText,
                  widgetIconPrefix: Icon(Icons.work),
                ),
                SizedBox(height: 15.h),
                CustomDropdown(
                  value: context.read<SignUPCubit>().selectedValue,
                  backgroundColor:ColorManager.fillColorTextFiled  ,
                  hintText: 'Choose Experience Level',
                  messageForValidate: 'please Choose Experience Level',
                  items: ['fresh', 'junior', 'midLevel', 'senior']
                      .map(
                        (e) => DropdownMenuItem(
                      value: e,
                      child:CustomTextWidget(
                                title: e,
                                 colorText: Colors.black,
                                 fontWeight: FontWeight.w300,
                                 size: 18.sp,
                              ),
                    ),
                  ).toList(),
                  onChange: (value) {
                    context.read<SignUPCubit>().selectedLevel(selectedValue:value!);
                  },
                ),
                SizedBox(height: 15.h),
                CustomTextFormFiled(
                  textEditingController:  context.read<SignUPCubit>().addressController,
                  textInputType: TextInputType.streetAddress,
                  obscureText: false,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please enter your Address';
                    }else{
                      return null;
                    }
                  },
                  hintText: TextManager.addressText,
                  widgetIconPrefix: Icon(Icons.location_on_rounded),
                ),
                SizedBox(height: 15.h),
                CustomTextFormFiled(
                  textEditingController:  context.read<SignUPCubit>().passwordController,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: context.read<SignUPCubit>().isVisiblePassword,
                  validator: (value) {
                    if(value!.isNotEmpty){
                      if(value.length<8){
                        return 'password is short';
                      }
                    }else if (value.isEmpty){
                      return 'Please enter Password ';
                    }
                    return null;
                  },
                  hintText: TextManager.passwordText,
                  widgetIconPrefix: Icon(Icons.lock),
                  widgetIconsuffix: IconButton(
                    onPressed: () {
                      context.read<SignUPCubit>().changeVisiblePassword();
                    },
                    icon: context.read<SignUPCubit>().isVisiblePassword? Icon(Icons.visibility_off):Icon(Icons.visibility),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    ) ;
  }
}
