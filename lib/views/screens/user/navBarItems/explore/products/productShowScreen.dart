import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/userSideModel/productShowModel.dart';
import 'package:brand/view_model/Controller/userSideController.dart/productShowController.dart';
import 'package:brand/views/screens/user/navBarItems/explore/products/productDetailScreen.dart';

class ProductShowScreen extends StatelessWidget {
  const ProductShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final showProducts =
        Provider.of<ProductShowController>(context).productModel?.products ??
            [];
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: showProducts.isEmpty
          ? SliverToBoxAdapter(
              child: Center(child: Text("No products found under this user")),
            )
          : SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = showProducts[index];
                  return PremiumCard(
                    title: product.productName ?? "Unnamed",
                    description: product.productDescription ??
                        "No description available",
                    image: product.images != null && product.images!.isNotEmpty
                        ? product.images!.first
                        : "https://via.placeholder.com/150",
                    product: product,
                    folderProducts: showProducts, // 👈 ye line add karo
                  );
                },
                childCount: showProducts.length,
              ),
            ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final Products product;
  final List<Products> folderProducts;

  const PremiumCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.product,
    required this.folderProducts,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserProductDetailScreen(
              product: product,
              folderProducts: folderProducts, // 👈 ab related products milenge
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // 🔹 Product Image
              Positioned.fill(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),

              // 🔹 Gradient Overlay (for readability)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // 🔹 Content
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(0, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
