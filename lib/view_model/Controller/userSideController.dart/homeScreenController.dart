import 'package:brand/barrelView/barrelView.dart';

class HomescreenController with ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  num totalPrice = 0;

  String userId = "";
  bool isUserIdLoaded = false;

  HomescreenController() {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("id") ?? "";
    print("✅ Loaded userId: $userId");
    isUserIdLoaded = true;
    notifyListeners();
  }

  /// return bottom screens dynamically
  List<Widget> get bottomScreens {
    return [
      ExploreScreen(),
      const Searchscreen(),
      isUserIdLoaded
          ? FavouriteScreen(userId: userId) // ✅ ab real userId pass ho raha hai
          : const Center(child: CircularProgressIndicator()), // loading
      const ProfileScreen(),
    ];
  }

  List<String> titles = [
    'Home',
    'Categories',
    'Favorites',
    'Settings',
  ];

  void changeBottom(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}
