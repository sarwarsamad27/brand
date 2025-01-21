import 'package:brand/barrelView/barrelView.dart';

class CategoryProvider with ChangeNotifier {
  final List<String> _categories = ['Men', 'Women', 'Summer', 'Winter', 'Kids'];
  String _selectedCategory = 'Men'; // Default selected category

  // Getter for categories
  List<String> get categories => _categories;

  // Getter for selected category
  String get selectedCategory => _selectedCategory;

  // Setter for selected category
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners(); // Notify listeners about the change
  }
}

/// Product Provider (PROVIDER)
class ProductProvider with ChangeNotifier {
  final List<ProductCard> products = List.generate(
    20,
    (index) => ProductCard(
      name: 'Product $index',
      shortDetails: 'Short description of Product $index',
      longDetails: ' $index',
      quantity: 1,
      color: 'Color: Blue',
      imageUrl:
          'https://images.pexels.com/photos/29371349/pexels-photo-29371349/free-photo-of-fashionable-man-in-orange-shirt-outdoors.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
  );

  ProductCard? selectedProduct;

  // Setter for selected product
  void setSelectedProduct(ProductCard product) {
    selectedProduct = product;
    notifyListeners(); // Notify listeners about the change
  }
}
