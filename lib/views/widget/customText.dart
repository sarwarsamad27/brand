import 'package:brand/barrelView/barrelView.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final VoidCallback? onTap;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
  final TextDecoration? textDecoration;
  final Color decorationColor;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.onTap,
    this.selectionColor,
    this.textHeightBehavior,
    this.textColor = AppColor.textPrimaryColor,
    this.fontWeight = AppFontWeight.w600,
    this.fontSize = AppFontSizes.font10,
    this.textDecoration,
    this.decorationColor = AppColor.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: style ??
            TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
                decorationColor: decorationColor,
                decoration: textDecoration),
        textAlign: textAlign ?? TextAlign.center,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow,
        maxLines: maxLines,
        locale: locale,
        strutStyle: strutStyle,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      ),
    );
  }
}
