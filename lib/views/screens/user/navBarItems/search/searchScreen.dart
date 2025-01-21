import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brand/barrelView/barrelView.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductDetailController>(context);
    // final profileScreenController =
    //     Provider.of<Profilescreencontroller>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Custom Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomSearchbar(
                controller: _searchController,
                onChanged: (value) {
                  productProvider.searchProducts(value);
                },
                // prefixIcon:  Icon(Icons.search),
                borderradius: 10,
                hintText: 'Search product or brand',
                // suffixicon: IconButton(
                //   icon: const Icon(Icons.clear),
                //   onPressed: () {
                //     _searchController.clear();
                //     productProvider.searchProducts(''); // Reset search
                //   },
                // ),
                prefixicon: Icon(Icons.search),
                suffixicon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    productProvider.searchProducts(''); // Reset search
                  },
                ),
              ),
            ),

            // Display Products
            Expanded(
              child: productProvider.filteredProducts.isNotEmpty
                  ? ListView.builder(
                      itemCount: productProvider.filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.filteredProducts[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(product.images[0]),
                          ),
                          title: Text(product.name),
                          subtitle: Text('Brand: ${product.name}'),
                          onTap: () {
                            productProvider.setSelectedProduct(product);
                            Navigator.pushNamed(
                                context, RoutesName.selectedProductScreen);
                          },
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Assets.searchIcon,
                            color: AppColor.popUpColor,
                            width: width * 0.2,
                            height: height * 0.2,
                          ),
                          const SizedBox(height: 16),
                          const Text('No products found.'),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
