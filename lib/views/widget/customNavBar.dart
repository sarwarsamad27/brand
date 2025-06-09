import 'package:brand/barrelView/barrelView.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0),
              blurRadius: 3.0,
            )
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        child: Stack(children: [
          BottomNavigationBar(
            backgroundColor: AppColor.appimagecolor,
            currentIndex: currentIndex,
            items: bottomNavigationBarItem,
            onTap: onTap,
            selectedLabelStyle: const TextStyle(
              color: AppColor.textSecondaryColor,
              fontWeight: FontWeight.bold,
            ),
            selectedItemColor: AppColor.appimagecolor,
            type: BottomNavigationBarType.fixed,
          ),
          _buildProgressBar(context, currentIndex)
        ]));
  }

  Widget _buildProgressBar(BuildContext context, int currentIndex) {
    double iconWidth = MediaQuery.of(context).size.width / icons.length;
    double progressBarWidth = iconWidth / 1.3;

    return Positioned(
      bottom: 0,
      left: iconWidth * currentIndex + (iconWidth - progressBarWidth) / 2,
      child: Container(
        decoration: const BoxDecoration(
            color: AppColor.appimagecolor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        width: progressBarWidth,
        height: 5,
      ),
    );
  }
}
