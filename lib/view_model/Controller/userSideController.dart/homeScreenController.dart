import 'package:brand/barrelView/barrelView.dart';

class HomescreenController with ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  num totalPrice = 0;
  List<Widget> bottomScreens = [
    ExploreScreen(
        // product: widget. product ,
        ),
    const Searchscreen(),
    const Favouritescreen(),
    const ProfileScreen(),
  ];

  List<String> titles = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];

  // List<ProductsModel> cartItems = [];

  // Change the selected bottom navigation index
  void changeBottom(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
