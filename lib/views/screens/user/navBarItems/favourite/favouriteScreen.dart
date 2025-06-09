import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/utiles/appHelpers.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';
import 'package:brand/views/widget/customAppbar.dart';

class Favouritescreen extends StatelessWidget {
  const Favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ComProductDetailController>(context);
    final favorites = productProvider.cart;
    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      appBar: modernAppBar(context,
          name: 'Favourite', detail: 'check your product'),
      body: Consumer<ComProductDetailController>(
        builder: (context, productProvider, child) {
          final favorites = productProvider.cart;

          return favorites.isEmpty
              ? const Center(
                  child: Text(
                    "Your favourites list is empty!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Column(
                  children: [
                    // List of Favorites
                    Expanded(
                      child: ListView.builder(
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final product = favorites[index];
                          return ListTile(
                            leading: SizedBox(
                              width: 50,
                              height: 50,
                              child: product.images.isNotEmpty
                                  ? Image.file(
                                      File(product.images[0]),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.image,
                                            size: 50, color: Colors.grey);
                                      },
                                    )
                                  : const Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                            ),
                            title: Text(product.name),
                            subtitle: Row(
                              children: [
                                Expanded(child: Text(product.description)),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 20),
                                  onPressed: () {
                                    productProvider.decreaseQuantity(product);
                                  },
                                ),
                                Text(
                                  '${product.price}',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 20),
                                  onPressed: () {
                                    productProvider.increaseQuantity(product);
                                  },
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final bool? confirm = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Confirm Delete'),
                                    content: const Text(
                                        'Are you sure you want to delete this item?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirm == true) {
                                  productProvider.removeFromCart(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${product.name} removed from favourites!'),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    // Conditionally Show "Proceed" Button
                    if (favorites.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onTap: () {
                              AppHelpers.showFullBottomSheet(context,
                                  OrderFormScreen(selectedProducts: favorites));
                            },
                            child: const Text("Proceed with favourite product"),
                          ),
                        ),
                      ),
                  ],
                );
        },
      ),
    );
  }
}
