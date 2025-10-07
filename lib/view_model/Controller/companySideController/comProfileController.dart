import 'package:brand/generate/companySideModels/comFormModel.dart';
import 'package:brand/generate/companySideModels/comProfileModel.dart';
import 'package:brand/view_model/Repository/CompanyRepository/comProfileRepository.dart';
import 'package:flutter/material.dart';

class ComProfileController extends ChangeNotifier {
  CompFormModel? profileModel;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchProfile(String email) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await ComProfileRepository.comProfileFetch(email);
      if (response.profile != null) {
        profileModel = response;
      } else {
        errorMessage = response.message ?? "❌ Failed to load profile";
      }
    } catch (e) {
      errorMessage = "❌ Error: $e";
    }

    isLoading = false;
    notifyListeners();
  }
}
