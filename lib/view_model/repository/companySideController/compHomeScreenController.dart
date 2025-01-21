import 'package:brand/barrelView/barrelView.dart';

class ComHomescreenController with ChangeNotifier {
  int currentIndex = 0;
  PageController comPageController = PageController(initialPage: 0);
  num totalPrice = 0;

  List<Widget> bottomScreens = [
    DashboardScreen(),
    SampleProductScreen(),
    ComOrdersScreen(),
    ComProfileScreen(),
  ];

  List<String> titles = [
    'DashBoard',
    'Product',
    'Order',
    'Profile',
  ];

  // List<ProductsModel> cartItems = [];

  // Change the selected bottom navigation index
  void changeBottom(int index) {
    currentIndex = index;
    comPageController.jumpToPage(index);
    notifyListeners();
  }

  // Add an item to the cart
  // void addToCart(ProductsModel model) {
  //   cartItems.add(model);
  //   calcTotal();
  //   notifyListeners();
}
