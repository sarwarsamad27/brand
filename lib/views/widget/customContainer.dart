import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final Widget? child;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? bgColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? borderColor;
  const CustomContainer({
    super.key,
    this.bgColor,
    this.borderColor,
    this.disabledTextColor,
    this.textStyle,
    this.disabledColor,
    this.textColor,
    this.title,
    required this.onTap,
    this.borderRadius,
    this.child,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: bgColor,
        ),
        child: child ??
            Text(
              title ?? "",
              style: textStyle,
            ),
      ),
    );
  }
}
