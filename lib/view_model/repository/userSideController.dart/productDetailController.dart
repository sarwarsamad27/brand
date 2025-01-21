import 'package:brand/barrelView/barrelView.dart';
import 'package:get/get.dart';
// Import your Product model here

/// Product Provider (PROVIDER)
class ProductDetailController with ChangeNotifier {
  // Sample list of products
  final List<Product> products = List.generate(
    20,
    (index) => Product(
      images: [
        'https://images.pexels.com/photos/29371349/pexels-photo-29371349/free-photo-of-fashionable-man-in-orange-shirt-outdoors.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1$index',
        'https://images.pexels.com/photos/21701368/pexels-photo-21701368/free-photo-of-cup-of-tea-and-candle-on-table.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1$index',
        'https://images.pexels.com/photos/28905003/pexels-photo-28905003/free-photo-of-giraffes-crossing-rail-tracks-in-african-savanna.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1$index',
        'https://images.pexels.com/photos/30009831/pexels-photo-30009831/free-photo-of-modern-wooden-facade-with-blue-windows.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load$index',
      ],
      name: 'Product $index',
      shortDetails: 'Short description of Product $index',
      color: 'Color: Blue',
      longDetails: '',
      quantity: 1,
      // Initial quantity
    ),
  );

  Product? selectedProduct;

  // Setter for selected product
  void setSelectedProduct(Product product) {
    selectedProduct = product;
    notifyListeners(); // Notify listeners about the change
  }

  final List<Product> cart = [];
  final List<Product> listSelectedProduct = [];

  // Add product to cart with quantity management
  void addToCart(Product product) {
    // Check if the product already exists in the cart
    Product? existingProduct =
        cart.firstWhereOrNull((p) => p.name == product.name);

    if (existingProduct != null) {
      // Increment the quantity if the product already exists
      existingProduct.quantity += 1;
    } else {
      // Add the product to the cart if it doesn't exist
      cart.add(product);
    }
    notifyListeners();
  }

  // Add all selected products to the list and cart
  void allSelectedProduct(Product product) {
    listSelectedProduct.add(product);
    addToCart(product); // Reuse addToCart for consistency
  }

  List<Product> filteredProducts = [];

  ProductDetailController() {
    filteredProducts = products; // Initialize with all products
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // Remove product from cart
  void removeFromCart(Product product) {
    Product? existingProduct =
        cart.firstWhereOrNull((p) => p.name == product.name);

    if (existingProduct != null) {
      if (existingProduct.quantity > 1) {
        // Decrement quantity if greater than 1
        existingProduct.quantity -= 1;
      } else {
        // Remove product completely if quantity is 1
        cart.remove(existingProduct);
      }
    }
    notifyListeners();
  }

  // Clear all items from the cart
  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}




// class ProductDetailController with ChangeNotifier {
//   final List<Product> products = List.generate(
//     20,
//     (index) => Product(
//       images: [
//         'https://images.pexels.com/photos/29371349/pexels-photo-29371349/free-photo-of-fashionable-man-in-orange-shirt-outdoors.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1$index',
//         'https://images.pexels.com/photos/21701368/pexels-photo-21701368/free-photo-of-cup-of-tea-and-candle-on-table.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1$index',
//         'https://images.pexels.com/photos/28905003/pexels-photo-28905003/free-photo-of-giraffes-crossing-rail-tracks-in-african-savanna.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1$index',
//         'https://images.pexels.com/photos/30009831/pexels-photo-30009831/free-photo-of-modern-wooden-facade-with-blue-windows.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load$index',
//       ],
//       name: 'Product $index',
//       brandName: 'Brand ${index % 5}', // Example brands
//       shortDetails: 'Details about Product $index',
//       color: 'Color: Blue',
//       longDetails: 'Long details about Product $index',
//       quantity: 1,
//     ),
//   );

//   Product? selectedProduct;
//   List<Product> filteredProducts = [];

//   ProductDetailController() {
//     filteredProducts = products; // Initialize with all products
//   }

//   void setSelectedProduct(Product product) {
//     selectedProduct = product;
//     notifyListeners();
//   }

//   void searchProducts(String query) {
//     if (query.isEmpty) {
//       filteredProducts = products;
//     } else {
//       filteredProducts = products
//           .where((product) =>
//               product.name.toLowerCase().contains(query.toLowerCase()) ||
//               product.brandName.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     notifyListeners();
//   }
// }
