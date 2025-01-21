import 'package:brand/barrelView/barrelView.dart';

class ProductFormProvider with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _discountController = TextEditingController();
  final List<String> images = [];
  String _selectedCategory = "Hoodies";

  final ImagePicker _picker = ImagePicker();

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

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.add(pickedFile.path);
      notifyListeners();
    }
  }

  CompanyProduct? selectedProduct;

  // Setter for selected product
  void setSelectedProduct(CompanyProduct companyProduct) {
    selectedProduct = companyProduct;
    notifyListeners(); // Notify listeners about the change
  }

  bool validateForm() {
    return _formKey.currentState?.validate() ?? false;
  }

  CompanyProduct saveProduct() {
    final newProduct = CompanyProduct(
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
    );
    return newProduct;
  }
}
