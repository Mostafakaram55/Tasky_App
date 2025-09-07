import 'package:flutter/cupertino.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.title,
    required this.colorText,
    required this.size,
    required this.fontWeight,
    this.maxLines
  });

  final String title;
  final Color colorText;
  final double size;
  final FontWeight fontWeight;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines:maxLines?? 1,
      overflow:TextOverflow.ellipsis,
      style: TextStyle(
        color: colorText,
        fontSize: size-2,
        fontWeight: fontWeight,
      ),
    );
  }
}