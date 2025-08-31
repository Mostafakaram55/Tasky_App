
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../../core/widgets/custom_text_filed_phone.dart';
import '../../../../core/widgets/custom_text_form_filed.dart';
import '../cubits/login_cubit/login_cubit.dart';

class LoginTextFiledSection extends StatelessWidget {
  const LoginTextFiledSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
