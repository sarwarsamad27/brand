import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/views/screens/company/productScreen/comEntryProductShowScreen.dart';
import 'package:brand/views/screens/company/profileScreen/comProfileScreen.dart';

class ComHomescreenController with ChangeNotifier {
  int currentIndex = 0;
  PageController comPageController = PageController(initialPage: 0);
  num totalPrice = 0;

  // List<CompanyProductUserSide> selectedProducts = []; // Store selected products
  final String userId;

  ComHomescreenController({required this.userId});
  List<Widget> get bottomScreens => [
        DashboardScreen(),
        ComEntryProductShowScreen(
          userId: userId,
        ),
        ComOrdersScreen(), // Pass the stored list
        CompanyProfileScreen(),
      ];

  List<String> titles = [
    'DashBoard',
    'Product',
    'Order',
    'Profile',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    comPageController.jumpToPage(index);
    notifyListeners();
  }

  // void updateSelectedProducts(List<CompanyProductUserSide> products) {
  //   selectedProducts = products;
  //   notifyListeners();
  // }
}
