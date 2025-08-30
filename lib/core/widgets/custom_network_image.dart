import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../config/icons/icons_broken.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class CustomNetworkImage extends StatelessWidget {
  final double? borderRadius;
  final String image;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double? radius8r;

  const CustomNetworkImage({super.key,
    this.borderRadius,
    required this.image,
    this.backgroundColor,
    this.height,
    this.width, this.fit,
    this.radius8r
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(radius8r??8 ),
        color: backgroundColor ?? ColorManager.white,
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: fit ?? BoxFit.cover,
        height: double.infinity,
        errorWidget: (context, url, error) =>
            Icon(
              IconBroken.Info_Square,
              color: ColorManager.buttonColor,
              size: 24,
            ),
      ),
    );
  }
}