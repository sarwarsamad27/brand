import 'package:brand/barrelView/barrelView.dart';

class CustomFullScreenBottomSheet extends StatelessWidget {
  final List<Widget> content;
  final String title;
  final Color? titleColor;
  final TextStyle? titleTextStyle;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final VoidCallback? crossIconOnPressed;
  final List<Widget>? actions;

  const CustomFullScreenBottomSheet(
      {super.key,
      required this.content,
      this.title = "",
      this.titleColor,
      this.titleTextStyle,
      this.titleFontSize,
      this.crossIconOnPressed,
      this.actions,
      this.titleFontWeight});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          color: AppColor.screenBgColor,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                title != ""
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              AppNavigators.pop(context);
                            },
                            child: Image.asset(
                              Assets.remove,
                              width: 10,
                              height: 10,
                              // later, cross icon will be added
                            ),
                          ),
                          Center(
                            child: CustomText(
                              text: title,
                              style: titleTextStyle ??
                                  AppTextStyles.h1.copyWith(
                                      fontWeight: titleFontWeight,
                                      color: titleColor,
                                      fontSize: titleFontSize),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: actions ?? [],
                          )
                        ],
                      )
                    : const SizedBox.shrink(),
                Column(
                  children: content,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
