import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/companySideController/compFormController.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final companyController = Provider.of<CompanyFormController>(context);
    final comproductController =
        Provider.of<ComProductDetailController>(context);
    final productController = Provider.of<ProductController>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      body: Column(
        children: [
          SizedBox(
            height: height * .05,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchbar(
              controller: _searchController,
              onChanged: (query) {
                productController.searchProduct(query);
              },
              borderradius: 10,
              hintText: 'Search product or brand',
              prefixicon: Icon(Icons.search),
              suffixicon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _searchController.clear();
                  productController.searchProduct('');
                },
              ),
            ),
          ),

          // Display Products
          Expanded(
            child: productController.products.isNotEmpty
                ? ListView.builder(
                    itemCount: productController.filterProduct.length,
                    itemBuilder: (context, index) {
                      final product = productController.products[index];
                      final companyName = companyController.nameController.text;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(File(productController
                              .filterProduct[index].images.first)),
                        ),
                        title: Text(companyName),
                        subtitle: Text('Product: ${product.name}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectedProductScreen(
                                product: product,
                              ),
                            ),
                          );
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
    );
  }
}
