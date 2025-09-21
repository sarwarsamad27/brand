import 'dart:io';
import 'package:brand/resources/global.dart';
import 'package:brand/view_model/Repository/CompanyRepository/comProductEntryRepository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brand/generate/companySideModels/comProductEntryModel.dart';

class ComProductEntryController with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  File? _pickedImage;
  File? get pickedImage => _pickedImage;

  bool isLoading = false;
  String? errorMessage;
  ComProductEntryModel? productResponse;

  // Pick image
  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _pickedImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      errorMessage = "Error picking image: $e";
      notifyListeners();
    }
  }

  void removeImage() {
    _pickedImage = null;
    notifyListeners();
  }

  // Save product (API call)
  Future<void> saveProduct(BuildContext context) async {
    if (nameController.text.isEmpty || _pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide product name & image')),
      );
      return;
    }

    isLoading = true;
    errorMessage = null;
    productResponse = null;
    notifyListeners();

    try {
      final result = await ComProductEntryRepository.addProduct(
        name: nameController.text.trim(),
        image: _pickedImage!,
        userId: Global.loggedInCompanyId ?? '',
      );

      if (result.product != null) {
        productResponse = result;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.message ?? "Product Added ✅")),
        );

        // Reset form
        nameController.clear();
        _pickedImage = null;
        Navigator.pop(context, true); // close form after save
      } else {
        errorMessage = result.message ?? "Something went wrong ❌";
      }
    } catch (e) {
      errorMessage = "Error: $e";
    }

    isLoading = false;
    notifyListeners();
  }
}
