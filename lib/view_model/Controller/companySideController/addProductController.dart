import 'dart:io';
import 'package:brand/view_model/Repository/CompanyRepository/createComProductRepository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brand/generate/companySideModels/createComProductModel.dart';

class CreateProductController with ChangeNotifier {
  // 🔹 Form controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final discountController = TextEditingController();

  // 🔹 Image Picker
  final List<String> images = [];
  final ImagePicker _picker = ImagePicker();

  // 🔹 Category (Color)
  String _selectedCategory = "Red";
  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // 🔹 Image Handling
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.add(pickedFile.path);
      notifyListeners();
    }
  }

  void removeImage(String imagePath) {
    images.remove(imagePath);
    notifyListeners();
  }

  // 🔹 API State
  bool _isLoading = false;
  String? _errorMessage;
  CreateComProductModel? _response;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  CreateComProductModel? get response => _response;

  // 🔹 Create Product API Call
  Future<void> createProduct({
    required String userId,
    required String brandId,
  }) async {
    if (images.isEmpty) {
      _errorMessage = "Please upload at least one image";
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final res = await CreateProductRepository.createProduct(
        productName: nameController.text,
        productDescription: descriptionController.text,
        price: priceController.text,
        stock: stockController.text,
        discount: discountController.text,
        userId: userId,
        brandId: brandId,
        category: _selectedCategory,
        images: images.map((e) => File(e)).toList(), // 👈 list bhejenge
      );

      _response = res;
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
