import 'package:brand/barrelView/barrelView.dart';

class CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child; // The child widget to display in the header

  CategoryHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
