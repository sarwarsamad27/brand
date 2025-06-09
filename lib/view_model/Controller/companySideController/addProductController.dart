import 'package:brand/barrelView/barrelView.dart';
import 'package:get/get.dart';

class ProductFormProvider with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _discountController = TextEditingController();
  final List<String> images = [];
  String _selectedCategory = "Hoodies";
  final List<CompanyProducts> cart = [];

  final ImagePicker _picker = ImagePicker();
  final List<CompanyProducts> listSelectedProduct = [];

  // Getters
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get nameController => _nameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get priceController => _priceController;
  TextEditingController get stockController => _stockController;
  TextEditingController get discountController => _discountController;

  String get selectedCategory => _selectedCategory;

  // Setters
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void removeImage(String imagePath) {
    images.remove(imagePath);
    notifyListeners();
  }

  void addToCart(CompanyProducts product) {
    CompanyProducts? existingProduct =
        cart.firstWhereOrNull((p) => p.name == product.name);

    if (existingProduct != null) {
      existingProduct.quantity += 1;
    } else {
      cart.add(product);
    }
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.add(pickedFile.path);
      notifyListeners();
    }
  }

  CompanyProducts? selectedProduct;

  // Setter for selected product
  void setSelectedProduct(CompanyProducts companyProduct) {
    selectedProduct = companyProduct;
    notifyListeners(); // Notify listeners about the change
  }

  void allSelectedProduct(CompanyProducts product) {
    listSelectedProduct.add(product);
    addToCart(product);
  }

  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  CompanyProducts saveProduct() {
    final newProduct = CompanyProducts(
      id: DateTime.now().toString(),
      name: _nameController.text,
      description: _descriptionController.text,
      category: _selectedCategory,
      price: double.parse(_priceController.text),
      stock: int.parse(_stockController.text),
      discountPrice: _discountController.text.isNotEmpty
          ? double.parse(_discountController.text)
          : null,
      images: images,
      sizes: ["S", "M", "L", "XL"],
      colors: ["Red", "Blue", "Black"],
      quantity: int.parse(_priceController.text),
    );
    return newProduct;
  }
}
