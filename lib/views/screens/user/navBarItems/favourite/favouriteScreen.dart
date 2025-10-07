import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/userSideController.dart/favouriteProductController.dart';
import 'package:brand/views/widget/customAppbar.dart';

class FavouriteScreen extends StatelessWidget {
  final String userId;
  const FavouriteScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavouriteController()..loadFavourites(userId),
      child: Consumer<FavouriteController>(
        builder: (context, favController, child) {
          if (favController.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final favourites = favController.favourites;
          final totalAmount = favController.totalAmount;

          return Scaffold(
            backgroundColor: AppColor.appbackgroundcolor,
            appBar: modernAppBar(
              context,
              name: "Favourites",
              detail: "Check your products",
            ),
            body: favourites.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border,
                            size: 80, color: Colors.grey),
                        SizedBox(height: 10),
                        Text(
                          "Your favourites list is empty!",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: favourites.length,
                          itemBuilder: (context, index) {
                            final fav = favourites[index];
                            final product = fav.product;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ✅ Product Image / Placeholder
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: (product?.images?.isNotEmpty ??
                                            false)
                                        ? Image.network(
                                            product!.images!.first,
                                            width: 90,
                                            height: 90,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                              width: 90,
                                              height: 90,
                                              color: Colors.grey[300],
                                              child: const Icon(Icons.image,
                                                  size: 40,
                                                  color: Colors.white),
                                            ),
                                          )
                                        : Container(
                                            width: 90,
                                            height: 90,
                                            color: Colors.grey[300],
                                            child: const Icon(Icons.image,
                                                size: 40, color: Colors.white),
                                          ),
                                  ),

                                  const SizedBox(width: 14),

                                  // ✅ Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product?.productName ?? "No name",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "Rs. ${product?.price ?? 0}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        // ✅ Quantity Controls
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                              onPressed: () {
                                                if (fav.quantity > 1) {
                                                  favController.updateQuantity(
                                                      fav, fav.quantity - 1);
                                                }
                                              },
                                            ),
                                            Text(
                                              "${fav.quantity}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.add_circle,
                                                color: Colors.green,
                                              ),
                                              onPressed: () {
                                                favController.updateQuantity(
                                                    fav, fav.quantity + 1);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ✅ Delete Button
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () async {
                                      await favController.removeFromFavourites(
                                        userId: userId,
                                        productId: product?.sId ?? "",
                                        context: context,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      // ✅ Total & Checkout
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 12,
                              offset: const Offset(0, -3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total:",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Rs. $totalAmount",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                final selectedProducts = favController
                                    .favourites
                                    .map((fav) => {
                                          "id": fav.product?.sId ?? "",
                                          "name":
                                              fav.product?.productName ?? "",
                                          "description":
                                              fav.product?.productDescription ??
                                                  "",
                                          "image":
                                              fav.product?.images?.isNotEmpty ==
                                                      true
                                                  ? fav.product!.images!.first
                                                  : "",
                                          "quantity": fav.quantity,
                                          "price": fav.product?.price ?? 0,
                                        })
                                    .toList();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FavouriteOrderFormScreen(
                                            selectedProducts: selectedProducts),
                                  ),
                                );
                              },
                              child: const Text(
                                "Proceed with these products",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
