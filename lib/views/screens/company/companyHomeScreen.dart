import '../../../barrelView/barrelView.dart';

class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ComHomescreenController>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(provider.titles[provider.currentIndex]),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.pushNamed(context, RoutesName.searchScreen);
      //       },
      //       icon: const Icon(
      //         Icons.search,
      //         color: Colors.redAccent,
      //       ),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Navigator.pushNamed(context, RoutesName.exploreScreen);
      //       },
      //       icon: const Icon(
      //         Icons.add_shopping_cart,
      //         color: Colors.redAccent,
      //       ),
      //     ),
      //   ],
      // ),
      body: PageView(
        controller: provider.comPageController,
        onPageChanged: provider.changeBottom,
        children: provider.bottomScreens,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          Icon(
            Icons.dashboard_outlined,
            color: Colors.white,
          ),
          Icon(
            Icons.dashboard_customize_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.arrow_outward_rounded,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
        ],
        index: provider.currentIndex,
        height: 60.0,
        color: AppColor.primaryColor,
        // buttonBackgroundColor: Colors.black26,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: provider.changeBottom,
        letIndexChange: (index) => true,
      ),
    );
  }
}
