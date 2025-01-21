import 'package:brand/barrelView/barrelView.dart';

class ProductController with ChangeNotifier {
  List<CompanyProduct> _products = [];

  List<CompanyProduct> get products => _products;

  void addProduct(CompanyProduct product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(CompanyProduct updatedProduct) {
    final index =
        _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct; // Update the product in the list
      notifyListeners(); // Notify listeners to update the UI
    } else {
      print("Product not found!");
    }
  }

  void deleteProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners(); // Notify listeners about the deletion
  }

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void goToNextImage(int imageCount) {
    _currentIndex = (_currentIndex + 1) % imageCount;
    notifyListeners();
  }

  void goToPreviousImage(int imageCount) {
    _currentIndex = (_currentIndex - 1 + imageCount) % imageCount;
    notifyListeners();
  }

  void setImageIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
