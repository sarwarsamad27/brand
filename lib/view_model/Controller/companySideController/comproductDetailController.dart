import 'package:brand/barrelView/barrelView.dart';
import 'package:get/get.dart';

class ComProductDetailController with ChangeNotifier {
  int currentIndex = 0;
  late final PageController pageController;
  List<CompanyProducts> filteredProducts = [];
  CompanyProducts? selectedProduct;
  final List<CompanyProducts> cart = [];
  final List<CompanyProducts> listSelectedProduct = [];
  final List<CompanyProducts> products = [];

  void addNewProduct(CompanyProducts product) {
    products.add(product);
    filteredProducts = List.from(products);
    notifyListeners();
  }

  void addToCart(CompanyProducts product) {
    CompanyProducts? existingProduct =
        cart.firstWhereOrNull((p) => p.name == product.name);

    if (existingProduct != null) {
      existingProduct.quantity += 1; // Increase quantity if product exists
    } else {
      product.quantity = 1; // Set quantity to 1 for new products
      cart.add(product);
    }
    notifyListeners();
  }

  void increaseQuantity(CompanyProducts product) {
    CompanyProducts? existingProduct =
        cart.firstWhereOrNull((p) => p.name == product.name);

    if (existingProduct != null) {
      existingProduct.quantity += 1;
    }
    notifyListeners();
  }

  void decreaseQuantity(CompanyProducts product) {
    CompanyProducts? existingProduct =
        cart.firstWhereOrNull((p) => p.name == product.name);

    if (existingProduct != null) {
      if (existingProduct.quantity > 1) {
        existingProduct.quantity -= 1;
      } else {
        cart.remove(existingProduct); // Remove if quantity is 1
      }
    }
    notifyListeners();
  }

  void allSelectedProduct(CompanyProducts product) {
    listSelectedProduct.add(product);
    addToCart(product);
  }

  void removeFromCart(CompanyProducts product) {
    cart.removeWhere(
        (p) => p.name == product.name); // Remove the product by name
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  ComProductDetailController() {
    pageController = PageController(initialPage: currentIndex);
    filteredProducts = List.from(products);
    // Optional: Add sample products for testing
    products.addAll([
      CompanyProducts(
        name: "Tech Gadget",
        images: ["https://picsum.photos/200/300?random=1"],
        colors: ["Black", "Silver"],
        price: 3233,
        description: "A cutting-edge tech gadget.",
        id: '',
        quantity: 1,
        category: '',
        stock: 1,
        sizes: [],
      ),
      CompanyProducts(
        name: "Tech Gadget",
        images: ["https://picsum.photos/200/300?random=1"],
        colors: ["Black", "Silver"],
        price: 3233,
        description: "A cutting-edge tech gadget.",
        id: '',
        quantity: 1,
        category: '',
        stock: 1,
        sizes: [],
      ),
    ]);
    filteredProducts = List.from(products);
  }

  void setImageIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void setSelectedProduct(CompanyProducts product) {
    selectedProduct = product;
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = List.from(products);
    } else {
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void goToNextImage(int totalImages) {
    if (currentIndex < totalImages - 1) {
      currentIndex++;
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void goToPreviousImage() {
    if (currentIndex > 0) {
      currentIndex--;
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }
}
