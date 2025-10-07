import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/userSideModel/productShowModel.dart';
import 'package:brand/view_model/Controller/userSideController.dart/favouriteProductController.dart';
import 'package:brand/view_model/Controller/userSideController.dart/productDetailController.dart';
import 'package:brand/views/screens/user/navBarItems/explore/products/orderFormSelectedprod.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:share_plus/share_plus.dart';

class UserProductDetailScreen extends StatefulWidget {
  final Products product;
  final List<Products> folderProducts;
  const UserProductDetailScreen({
    super.key,
    required this.product,
    required this.folderProducts,
  });

  @override
  State<UserProductDetailScreen> createState() =>
      _UserProductDetailScreenState();
}

class _UserProductDetailScreenState extends State<UserProductDetailScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductDetailController()
            ..loadProductDetail(widget.product, widget.folderProducts),
        ),
        ChangeNotifierProvider(
          create: (_) => FavouriteController(),
        ),
      ],
      child: Consumer2<ProductDetailController, FavouriteController>(
        builder: (context, controller, cartController, _) {
          if (controller.isLoading || controller.product == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final product = controller.product!;

          return Scaffold(
            backgroundColor: Colors.grey[100],
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Image Carousel with Fullscreen Zoom
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider.builder(
                        itemCount: product.images?.length ?? 0,
                        itemBuilder: (context, index, realIndex) {
                          return GestureDetector(
                            onTap: () {
                              /// ✅ Fullscreen Image Viewer
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Scaffold(
                                    backgroundColor: Colors.black,
                                    appBar: AppBar(
                                      backgroundColor: Colors.black,
                                      iconTheme: const IconThemeData(
                                          color: Colors.white),
                                    ),
                                    body: PhotoViewGallery.builder(
                                      itemCount: product.images?.length ?? 0,
                                      pageController:
                                          PageController(initialPage: index),
                                      builder: (context, pageIndex) {
                                        return PhotoViewGalleryPageOptions(
                                          imageProvider: NetworkImage(
                                              product.images![pageIndex]),
                                          minScale:
                                              PhotoViewComputedScale.contained,
                                          maxScale:
                                              PhotoViewComputedScale.covered *
                                                  3,
                                        );
                                      },
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      backgroundDecoration: const BoxDecoration(
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                product.images![index],
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.5,
                          viewportFraction: 1,
                          autoPlay: true,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() => activeIndex = index);
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: AnimatedSmoothIndicator(
                          activeIndex: activeIndex,
                          count: product.images?.length ?? 0,
                          effect: const ExpandingDotsEffect(
                            dotHeight: 8,
                            dotWidth: 8,
                            activeDotColor: Colors.black,
                            dotColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // 🔹 Product Info Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName ?? "",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Rs. ${product.price ?? 0}",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            if (product.discount != null &&
                                product.discount! > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "-${product.discount}% OFF",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.productDescription ??
                              "No description available",
                          style: const TextStyle(fontSize: 15, height: 1.5),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Stock: ${product.stock ?? 0}",
                          style: TextStyle(
                            fontSize: 14,
                            color: (product.stock ?? 0) > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 🔹 Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final userId = prefs.getString("id") ?? "";
                              cartController.addToFavourites(
                                productId: product.sId ?? "",
                                userId:
                                    userId, // ✅ replace with logged-in userId
                                context: context,
                              );
                            },
                            child: cartController.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OrderCreateScreen(
                                      selectedProduct: product,
                                    ),
                                  ));
                            },
                            child: const Text(
                              "Buy Now",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🔹 Related Products
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Related Products",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.relatedProducts.length,
                      itemBuilder: (context, index) {
                        final related = controller.relatedProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserProductDetailScreen(
                                  product: related,
                                  folderProducts: widget.folderProducts,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    related.images?.isNotEmpty == true
                                        ? related.images!.first
                                        : "https://via.placeholder.com/150",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    related.productName ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    "Rs. ${related.price ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
