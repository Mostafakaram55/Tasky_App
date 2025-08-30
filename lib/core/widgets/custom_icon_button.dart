import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,required this.iconBroken,
    required this.operation,
    required this.colorIcon
  });
  final IconData iconBroken;
  final void Function()? operation;
  final Color colorIcon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: operation,
        icon:Icon(
          iconBroken,
          color: colorIcon,
        ) );
  }
}