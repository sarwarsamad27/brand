import 'package:brand/barrelView/barrelView.dart';

class Productscreen extends StatelessWidget {
  const Productscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the providers
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final productProvider = Provider.of<ProductDetailController>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image (WIDGET)
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://images.pexels.com/photos/29371349/pexels-photo-29371349/free-photo-of-fashionable-man-in-orange-shirt-outdoors.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // Placeholder image
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Persistent Header for Categories (WIDGET)
          SliverPersistentHeader(
            pinned: true,
            delegate: CategoryHeaderDelegate(
              child: Container(
                color: Colors.grey[200],
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryProvider.categories.length,
                  itemBuilder: (context, index) {
                    final category = categoryProvider.categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: categoryProvider.selectedCategory == category,
                        onSelected: (_) =>
                            categoryProvider.setSelectedCategory(category),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Product Grid (WIDGET)
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = productProvider.products[index];
                  return InkWell(
                    onTap: () {
                      productProvider.setSelectedProduct(product);
                      Navigator.pushNamed(
                          context, RoutesName.selectedProductScreen);
                    },
                    child: ProductCard(
                      imageUrl: product.images[0],
                      name: product.name,
                      shortDetails: product.shortDetails,
                      color: product.color,
                    ),
                  );
                },
                childCount: productProvider.products.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7, // Adjust aspect ratio
              ),
            ),
          ),
        ],
      ),
    );
  }
}
