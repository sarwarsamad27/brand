import 'package:brand/barrelView/barrelView.dart';

class ComProductsScreen extends StatelessWidget {
  final SampleProductModel product;
  ComProductsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    // final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar with FlexibleSpace for Product Details
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.name),
              background: Image.file(
                File(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Product Details Section
          // SliverList(
          //   delegate: SliverChildListDelegate(
          //     [
          //       const Padding(
          //         padding: EdgeInsets.all(16.0),
          //         child: Text(
          //           "Product Details",
          //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.all(16.0),
          //         child: Text(
          //           "This is the detailed description of the product. "
          //           "Add more fields or content as necessary.",
          //           style: TextStyle(fontSize: 16),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // Product List Grid (wrapped in SliverToBoxAdapter for CustomScrollView compatibility)
          SliverToBoxAdapter(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                final product = productController.products[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Product Image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12.0),
                            ),
                            child: product.images.isNotEmpty &&
                                    product.images.first.isNotEmpty
                                ? (Uri.tryParse(product.images.first)
                                            ?.isAbsolute ==
                                        true
                                    ? Image.network(
                                        product.images.first,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      )
                                    : Image.file(
                                        File(product.images.first),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Center(
                                          child: Icon(
                                            Icons.broken_image,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ))
                                : const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ),
                        ),

                        // Product Name
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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

      // Floating Action Button to Add New Products
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
