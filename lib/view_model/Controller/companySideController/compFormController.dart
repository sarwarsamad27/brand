import 'dart:io';
import 'package:brand/route/routes.dart';
import 'package:brand/view_model/Repository/CompanyRepository/comFormRepository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:brand/generate/companySideModels/comFormModel.dart';

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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CompanyFormController() {
    _loadFormStatus(); // 🔹 Jab controller banega, saved status load ho jayega
  }

  Future<void> _loadFormStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isFormSubmitted = prefs.getBool('formSubmitted') ?? false;
    notifyListeners();
  }

  /// Pick image from gallery
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Preserve formSubmitted and form data
    bool? isFormAlreadySubmitted = prefs.getBool('formSubmitted');

    await prefs.clear(); // clear all

    // Restore form data if needed
    if (isFormAlreadySubmitted == true) {
      await prefs.setBool('formSubmitted', true);
      // optionally restore other form fields
      // await prefs.setString(...);
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.comLogInScreen,
      (route) => false,
    );
  }

  /// Capture image from camera
  Future<void> captureImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  /// Clear image
  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  /// 🚀 Submit company form (API + Local save)
  Future<CompFormModel?> registerCompanyForm(BuildContext context) async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a company logo")),
      );
      return null;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await ComFormRepository.comForm(
        name: nameController.text.trim(),
        image: _selectedImage!,
        email: emailController.text.trim(),
        mobile: contactController.text.trim(),
        address: addressController.text.trim(),
        description: descriptionController.text.trim(),
      );

      _isLoading = false;
      notifyListeners();

      if (response.profile != null) {
        // ✅ Success → Save locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('formSubmitted', true);
        await prefs.setString('companyName', response.profile!.name ?? '');
        await prefs.setString('companyId', response.profile!.sId ?? '');
        await prefs.setString('companyEmail', response.profile!.email ?? '');
        await prefs.setString(
            'companyAddress', response.profile!.address ?? '');
        await prefs.setString('companyContact', response.profile!.mobile ?? '');
        await prefs.setString(
            'companyDescription', response.profile!.description ?? '');
        await prefs.setString('companyImage', response.profile!.image ?? '');

        _isFormSubmitted = true;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("✅ Company profile submitted successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? "❌ Submission failed")),
        );
      }

      return response;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
      return null;
    }
  }
}
