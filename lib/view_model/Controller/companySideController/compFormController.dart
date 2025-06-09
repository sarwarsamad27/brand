import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert'; // Required for JSON encoding/decoding

class CompanyFormController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  File? get selectedImage => _selectedImage;
  bool _isFormSubmitted = false;
  bool get isFormSubmitted => _isFormSubmitted;

  List<Map<String, String>> allBrands = [];
  List<Map<String, String>> _filteredBrands = [];

  CompanyFormController() {
    _filteredBrands = List.from(allBrands);
  }

  List<Map<String, String>> get filteredBrands => _filteredBrands;
  int get registeredCompanyCount => _filteredBrands.length;

  void filterBrands(String query) {
    if (query.isEmpty) {
      _filteredBrands = allBrands;
    } else {
      _filteredBrands = allBrands
          .where((brand) =>
              brand["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify the UI to rebuild
  }

  Future<void> saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, String> newBrand = {
      "name": nameController.text.trim(),
      "image": _selectedImage?.path ?? "",
    };

    List<String> existingBrands = prefs.getStringList('registeredBrands') ?? [];

    existingBrands.add(jsonEncode(newBrand));
    await prefs.setStringList('registeredBrands', existingBrands);

    await prefs.setString('comProfileName', nameController.text);
    await prefs.setString('comProfileAddress', addressController.text);
    await prefs.setString('comProfileEmail', emailController.text);
    await prefs.setString('comProfileContact', contactController.text);

    if (_selectedImage != null) {
      await prefs.setString('comProfileImage', _selectedImage!.path);
    }

    await prefs.setBool('isFormSubmitted', true);

    await loadRegisteredBrands();
    notifyListeners();
  }

  Future<void> loadRegisteredBrands() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> storedBrands = prefs.getStringList('registeredBrands') ?? [];
    print("🔍 Stored Brands: $storedBrands");
    _filteredBrands = storedBrands
        .map((brand) => Map<String, String>.from(jsonDecode(brand)))
        .toList();

    _filteredBrands = List.from(allBrands);
    notifyListeners();
  }

  Future<void> loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('companyName') ?? '';
    addressController.text = prefs.getString('companyAddress') ?? '';
    emailController.text = prefs.getString('companyEmail') ?? '';
    contactController.text = prefs.getString('companyContact') ?? '';
    descriptionController.text = prefs.getString('companyDescription') ?? '';

    String? imagePath = prefs.getString('companyImage');
    if (imagePath != null) {
      _selectedImage = File(imagePath);
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  /// **Capture image using camera**
  Future<void> captureImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  /// **Clear the selected image**
  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  /// **Edit function for updating profile data**
  Future<void> editProfileData() async {
    await saveProfileData();
    notifyListeners();
  }
}
