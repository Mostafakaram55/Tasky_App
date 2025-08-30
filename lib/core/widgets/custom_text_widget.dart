import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.title,
    required this.colorText,
    required this.size,
    required this.fontWeight
  });

  final String title;
  final Color colorText;
  final double size;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow:TextOverflow.ellipsis,
      style: GoogleFonts.montserrat(
        color: colorText,
        fontSize: size.r,
        fontWeight: fontWeight,
      ),
    );
  }
}