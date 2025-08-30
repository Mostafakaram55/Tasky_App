import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
class TextFormFiledPhone extends StatelessWidget {
  const TextFormFiledPhone({super.key, required this.phoneController, required this.onChanged});
  final TextEditingController phoneController;
  final Function(PhoneNumber phoneNumber) onChanged;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller:phoneController ,
      initialCountryCode: 'EG',
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: '123-456-789',
        hintStyle: TextStyle(
            color: Color(0xFFBABABA),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400
        ),
        fillColor: ColorManager.fillColorTextFiled ,
        filled: true,
        border: AppConstants.enabledBorder,
        focusedBorder: AppConstants.focusedBorder,
      ),
    );
  }
}