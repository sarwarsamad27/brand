import 'package:brand/barrelView/barrelView.dart';

class ProductController with ChangeNotifier {
  List<CompanyProducts> _products = [];

  List<CompanyProducts> get products => _products;

  List<CompanyProducts> filterProduct = [];

  ProductController() {
    filterProduct = List.from(_products);
  }

  CompanyProducts? selectedProduct;

  void setSelectedProduct(CompanyProducts product) {
    selectedProduct = product;
    notifyListeners();
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      filterProduct = List.from(_products);
    } else {
      filterProduct = _products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void addProduct(CompanyProducts product) {
    _products.add(product);
    filterProduct = List.from(_products); // Ensure filter list updates
    notifyListeners();
  }

  void updateProduct(CompanyProducts updatedProduct) {
    final index =
        _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    } else {
      debugPrint("⚠️ Product with ID ${updatedProduct.id} not found!");
    }
  }

  void deleteProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
    filterProduct = List.from(_products); // Ensure UI updates
    notifyListeners();
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
