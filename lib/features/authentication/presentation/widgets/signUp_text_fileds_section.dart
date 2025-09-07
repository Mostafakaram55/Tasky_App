
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky_app/core/utils/app_strings.dart';
import 'package:tasky_app/features/authentication/presentation/cubits/register_cubit/register_state.dart';
import '../../../../../core/widgets/custom_text_widget.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';
import '../../../../core/widgets/custom_text_filed_phone.dart';
import '../cubits/register_cubit/register_cubit.dart';

class SignUpSectionTextFiled extends StatelessWidget {
  const SignUpSectionTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUPCubit, SignUpStates>(
    builder: (context, state) {
    return Column(
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
              return TextManager.validationName;
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
              return TextManager.validationExperienceYears;
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
                fontWeight: FontWeight.w400,
                size: 16.sp,
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
              return TextManager.validationAddress;
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
          widgetIconPrefix: Icon(Icons.lock),
          widgetIconsuffix: IconButton(
            onPressed: () {
              context.read<SignUPCubit>().changeVisiblePasswordS();
            },
            icon: context.read<SignUPCubit>().isVisiblePasswordS ? Icon(Icons.visibility_off, size: 20.sp) : Icon(Icons.visibility, size: 20.sp),
          ),
          obscureText: context.read<SignUPCubit>().isVisiblePasswordS,
          validator: (value) {
            if(value!.isNotEmpty){
              if(value.length<8){
                return TextManager.passwordIsShort;
              }
            }else if (value.isEmpty){
              return TextManager.errorValidatorPassword;
            }
            return null;
          },
          hintText: TextManager.passwordText,

        ),
        SizedBox(height: 20.h),
      ],
    );
  },
);
  }
}
