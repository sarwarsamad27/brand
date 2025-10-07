import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/userSideController.dart/searchScreenController.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final productController =
          Provider.of<SearchProductController>(context, listen: false);

      if (productController.allProducts.isEmpty) {
        productController.fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProductController>(
      builder: (context, productController, child) {
        if (productController.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final products = productController.filteredProducts;

        return Scaffold(
          backgroundColor: AppColor.appbackgroundcolor,
          appBar: AppBar(
            title: const Text("Search Products"),
            backgroundColor: AppColor.primaryColor,
          ),
          body: Column(
            children: [
              // 🔍 Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (query) {
                    productController.searchProduct(query);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search product or brand',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        productController.searchProduct('');
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),

              // 🛍 Products Grid
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    final productController =
                        Provider.of<SearchProductController>(context,
                            listen: false);
                    await productController.fetchProducts();
                    productController.shuffleProducts(); // shuffle on refresh
                  },
                  child: products.isNotEmpty
                      ? GridView.builder(
                          padding: const EdgeInsets.all(12),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: (product.images?.isNotEmpty ??
                                              false)
                                          ? Image.network(
                                              product.images!.first,
                                              height: 70,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                    Icons.shopping_bag,
                                                    size: 70,
                                                    color: Colors.grey);
                                              },
                                            )
                                          : const Icon(Icons.shopping_bag,
                                              size: 70, color: Colors.grey),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      product.productName ?? "No name",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      product.company ?? "No brand",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Rs. ${product.price ?? 0}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView(
                          // RefreshIndicator ke liye empty state me bhi scrollable chahiye
                          children: const [
                            SizedBox(height: 200),
                            Center(
                              child: Column(
                                children: [
                                  Icon(Icons.search_off,
                                      size: 80, color: Colors.grey),
                                  SizedBox(height: 10),
                                  Text("No products found."),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
