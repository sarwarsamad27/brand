import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/userSideController.dart/homeScreenController.dart';
import 'package:brand/views/widget/navBar.dart';

// class Homescreen extends StatefulWidget {
//   const Homescreen({super.key});

//   @override
//   _HomescreenState createState() => _HomescreenState();
// }

// class _HomescreenState extends State<Homescreen> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     const Explorescreen(),
//     const Searchscreen(),
//     const Favouritescreen(),
//     const ProfileScreen(),
//   ];

// class Homescreen with ChangeNotifier {
//   int currentIndex = 0;
//   PageController pageController = PageController(initialPage: 0);
//   num totalPrice = 0;

//   List<Widget> bottomScreens = [
//     const Explorescreen(),
//     const Searchscreen(),
//     const Favouritescreen(),
//     const ProfileScreen(),
//   ];

//   List<String> titles = [
//     'Home',
//     'Categories',
//     'Favorites',
//     'Settings',
//   ];

//   // List<ProductsModel> cartItems = [];

//   // Change the selected bottom navigation index
//   void changeBottom(int index) {
//     currentIndex = index;
//     pageController.jumpToPage(index);
//     notifyListeners();
//   }

// Add an item to the cart
// void addToCart(ProductsModel model) {
//   cartItems.add(model);
//   calcTotal();
//   notifyListeners();
// }

// Remove an item from the cart
// void removeFromCart(int index) {
//   cartItems.removeAt(index);
//   calcTotal();
//   notifyListeners();
// }

// Calculate total price of cart items
// void calcTotal() {
//   totalPrice = cartItems.fold(0, (sum, item) => sum + item.price);
//   notifyListeners();
// }
// }

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomescreenController>(context);
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
        controller: provider.pageController,
        onPageChanged: provider.changeBottom,
        children: provider.bottomScreens,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          Icon(
            Icons.explore,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
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
