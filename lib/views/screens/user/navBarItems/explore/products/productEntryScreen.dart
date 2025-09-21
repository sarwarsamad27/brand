import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/userSideController.dart/productEntryController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/productShowController.dart';
import 'package:brand/views/screens/user/navBarItems/explore/products/productShowScreen.dart';

class ProductEntryScreen extends StatefulWidget {
  final String userId;
  const ProductEntryScreen({super.key, required this.userId});

  @override
  _ProductEntryScreenState createState() => _ProductEntryScreenState();
}

class _ProductEntryScreenState extends State<ProductEntryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductEntryController()..loadProducts(widget.userId),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductShowController(),
        ),
      ],
      child: Consumer2<ProductEntryController, ProductShowController>(
        builder: (context, entryController, showController, _) {
          if (entryController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (entryController.productModel == null ||
              entryController.productModel!.products!.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          final products = entryController.productModel!.products!;

          // ✅ First time load, chip[0] ka data auto fetch karo
          if (showController.currentBrandId == null && products.isNotEmpty) {
            final first = products[0];
            showController.loadProducts(first.user ?? "", first.sId ?? "");
          }

          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: CustomScrollView(
              slivers: [
                /// 🔥 Premium SliverAppBar
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.45,
                  pinned: true,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      products[_selectedIndex].name ?? "Product",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    background: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          products[_selectedIndex].image != null
                              ? Image.network(
                                  products[_selectedIndex].image!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image,
                                  size: 80, color: Colors.white70),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black54],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// 🔥 Choice Chips
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CategoryHeaderDelegate(
                    child: Container(
                      color: Colors.white,
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: ChoiceChip(
                              label: Text(
                                product.name ?? "Unnamed",
                                style: TextStyle(
                                  color: _selectedIndex == index
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                              selected:
                                  showController.currentBrandId == product.sId,
                              selectedColor: Colors.blueGrey.shade700,
                              onSelected: (selected) {
                                if (selected) {
                                  final brandId = product.sId ?? "";
                                  final userId = product.user ?? "";

                                  /// 🔥 update ProductShowController
                                  showController.loadProducts(userId, brandId);

                                  /// 🔥 update local index for AppBar
                                  setState(() {
                                    _selectedIndex = index;
                                    _animationController.reset();
                                    _animationController.forward();
                                  });
                                }
                              },
                              backgroundColor: Colors.grey.shade200,
                              elevation: 3,
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                /// 🔥 Product Grid
                ProductShowScreen()
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Sliver Header Delegate
class CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  CategoryHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;
  @override
  double get minExtent => 60;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

// /// Sliver Header Delegate
// class CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   CategoryHeaderDelegate({required this.child});

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   double get maxExtent => 60;
//   @override
//   double get minExtent => 60;
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       true;
// }
