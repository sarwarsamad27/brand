import 'package:brand/barrelView/barrelView.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 16,
          ),
        ),
        const Column(
          children: [
            CustomText(
              text: "Terms And Conditions",
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                CustomText(
                  text: "LAST UPDATED ",
                  style: TextStyle(
                      color: AppColor.textSecondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
                CustomText(
                  text: "14/08/2025",
                  style: TextStyle(
                      color: AppColor.textSecondaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 25,
        )
      ],
    );
  }
}
