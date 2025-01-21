import 'package:brand/barrelView/barrelView.dart';

final List<String> icons = [
  'assets/Images/bottom_nav_bar/explore',
  'assets/Images/bottom_nav_bar/search',
  'assets/Images/bottom_nav_bar/favorite',
  'assets/Images/bottom_nav_bar/setting',
];

final List<BottomNavigationBarItem> bottomNavigationBarItem = [
  const BottomNavigationBarItem(
    activeIcon: Icon(Icons.explore),
    icon: Icon(Icons.explore_off),
    label: 'Explore',
  ),
  const BottomNavigationBarItem(
    activeIcon: Icon(Icons.search),
    icon: Icon(Icons.search_off),
    label: 'Search',
  ),
  const BottomNavigationBarItem(
    activeIcon: Icon(Icons.favorite),
    icon: Icon(Icons.favorite_border_rounded),
    label: 'Favourite',
  ),
  const BottomNavigationBarItem(
    activeIcon: Icon(Icons.person),
    icon: Icon(Icons.person_2_outlined),
    label: 'You',
  )
];
