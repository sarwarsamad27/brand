import '../../../barrelView/barrelView.dart';

class SampleProductController with ChangeNotifier {
  final List<SampleProductModel> _products = [];
  List<SampleProductModel> _filteredProducts = [];
  final TextEditingController nameController = TextEditingController();

  List<SampleProductModel> get products => _products;
  List<SampleProductModel> get filteredProducts =>
      _filteredProducts.isEmpty ? _products : _filteredProducts;
  File? get pickedImage => _pickedImage;
  File? _pickedImage;

  int _selectedIndex = 0; // -1 means no selection
  int get selectedIndex => _selectedIndex;

  // Method to update the selected index
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _pickedImage = File(pickedFile.path);
        notifyListeners();
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // Remove the selected image
  void removeImage() {
    _pickedImage = null;
    notifyListeners();
  }

  void addProduct(SampleProductModel product) {
    _products.add(product);
    notifyListeners();
  }

  void deleteProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    _filteredProducts.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  void saveProduct(BuildContext context) {
    if (nameController.text.isEmpty || _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide all details')),
      );
      return;
    }

    final newProduct = SampleProductModel(
      id: DateTime.now().toString(),
      name: nameController.text,
      imageUrl: _pickedImage!.path,
    );

    addProduct(newProduct);

    // Clear the form and reset the controller and picked image
    nameController.clear();
    _pickedImage = null;
    notifyListeners();

    Navigator.of(context).pop();
  }

  void setPickedImage(String imagePath) {
    _pickedImage = File(imagePath); // Set the image from the existing product
    notifyListeners();
  }

  filterProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = _products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void editProduct(String id, String newName, String newImageUrl) {
    int index = _products.indexWhere((product) => product.id == id);
    if (index != -1) {
      _products[index] = SampleProductModel(
        id: _products[index].id,
        name: newName,
        imageUrl: newImageUrl,
      );
    }
    notifyListeners();
  }
}
