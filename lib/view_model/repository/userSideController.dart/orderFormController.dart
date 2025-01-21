import 'package:brand/barrelView/barrelView.dart';

// class Orderformcontroller extends ChangeNotifier {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController homeAddressController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController postalCodeController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

// final nameFocusNode = FocusNode();
// final emailFocusNode = FocusNode();
// final phoneFocusNode = FocusNode();
// final cityFocusNode = FocusNode();
// final postalCodeFocusNode = FocusNode();
// final homeAddressFocusNode = FocusNode();

// void submitForm(BuildContext context) {
//   if (formKey.currentState!.validate()) {
//     // Process the form
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Order Submitted Successfully!')),
//     );
//     // Clear the fields after submission
//     nameController.clear();
//     homeAddressController.clear();
//     phoneController.clear();
//     emailController.clear();
//     countryController.clear();
//     cityController.clear();
//     postalCodeController.clear();
//     notifyListeners();
//   }
// }
// @override
// void dispose() {
//   // Dispose of all FocusNodes and controllers to prevent memory leaks
//   nameFocusNode.dispose();
//   emailFocusNode.dispose();
//   phoneFocusNode.dispose();
//   cityFocusNode.dispose();
//   postalCodeFocusNode.dispose();
//   homeAddressFocusNode.dispose();

//   nameController.dispose();
//   emailController.dispose();
//   phoneController.dispose();
//   cityController.dispose();
//   postalCodeController.dispose();
//   homeAddressController.dispose();

//   super.dispose();
// }

// String? selectedCountry;
// final List<String> countryList = [
//   'Pakistan',
//   'India',
//   'america',
//   'germany',
//   'italy',
//   'france',
//   'nepal',
// ];

// void dropDownChangeValue(String? newValue) {
//   selectedCountry = newValue;
//   notifyListeners();
// }

// void validateField() {
//   if (formKey.currentState != null) {
//     formKey.currentState!
//         .validate(); // Triggers the validation for all fields in the form.
//   }
// }

//   String? validateName(String? value) {
//     // Clear error on focus
//     if (value == null || value.isEmpty) {
//       return 'Please enter your name';
//     }
//     if (nameFocusNode.hasFocus) return null;
//     return null;
//   }

//   String? validateEmail(String? value) {
//     if (emailFocusNode.hasFocus) return null; // Clear error on focus
//     if (value == null || value.isEmpty) {
//       return 'Please enter your email';
//     }
//     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//       return 'Enter a valid email address';
//     }
//     return null;
//   }

//   String? validatePhone(String? value) {
//     if (phoneFocusNode.hasFocus) return null; // Clear error on focus
//     if (value == null || value.isEmpty) {
//       return 'Please enter your phone number';
//     }
//     if (!RegExp(r'^(03|04|05)[0-9]{9}$').hasMatch(value)) {
//       return 'Enter a valid Pakistani phone number';
//     }
//     return null;
//   }

//   String? validateCity(String? value) {
//     if (cityFocusNode.hasFocus) return null; // Clear error on focus
//     if (value == null || value.isEmpty) {
//       return 'Please enter your city';
//     }
//     return null;
//   }

//   String? validatePostalCode(String? value) {
//     if (postalCodeFocusNode.hasFocus) return null; // Clear error on focus
//     if (value == null || value.isEmpty) {
//       return 'Please enter your postal code';
//     }
//     if (!RegExp(r'^\d{5}$').hasMatch(value)) {
//       return 'Enter a valid postal code';
//     }
//     return null;
//   }

//   String? validateHomeAddress(String? value) {
//     if (homeAddressFocusNode.hasFocus) return null; // Clear error on focus
//     if (value == null || value.isEmpty) {
//       return 'Please enter your home address';
//     }
//     return null;
//   }

//   // Submit the form
//   void submitForm(BuildContext context) {
//     if (formKey.currentState!.validate()) {
//       // If all fields pass validation, submit the form
//       Navigator.pop(context);
//       // Add any other form submission logic here
//     } else {
//       // Show error message if validation fails
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix the errors in the form.')),
//       );
//     }
//   }

//   bool isEditing = false; // Tracks if the fields are in edit mode

//   void toggleEditMode() {
//     isEditing = !isEditing;
//     notifyListeners();
//   }

//   void saveAddress(BuildContext context) {
//     if (formKey.currentState!.validate()) {
//       isEditing = false; // Disable editing after saving
//       notifyListeners();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Address saved successfully!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix the errors before saving.')),
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';

class Orderformcontroller extends ChangeNotifier {
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  // Key for form validation
  final formKey = GlobalKey<FormState>();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final postalCodeFocusNode = FocusNode();
  final homeAddressFocusNode = FocusNode();
  final countryFocusNode = FocusNode();

  @override
  void dispose() {
    // Dispose of all FocusNodes and controllers to prevent memory leaks
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    cityFocusNode.dispose();
    postalCodeFocusNode.dispose();
    homeAddressFocusNode.dispose();
    countryFocusNode.dispose();

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    homeAddressController.dispose();
    countryController.dispose();

    super.dispose();
  }

  String? selectedCountry;
  final List<String> countryList = [
    'Pakistan',
    'India',
    'america',
    'germany',
    'italy',
    'france',
    'nepal',
  ];

  void dropDownChangeValue(String? newValue) {
    selectedCountry = newValue;
    notifyListeners();
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      // Process the form
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order Submitted Successfully!')),
      );
      // Clear the fields after submission
      nameController.clear();
      homeAddressController.clear();
      phoneController.clear();
      emailController.clear();
      countryController.clear();
      cityController.clear();
      postalCodeController.clear();
      notifyListeners();
    }
  }

  // List to store saved addresses
  List<Map<String, String>> savedAddresses = [];

  // Toggle edit mode
  bool isEditing = false;

  void toggleEditMode() {
    isEditing = !isEditing;
    notifyListeners();
  }

  // Save the current form data as a new address
  void saveCurrentAddress() {
    final newAddress = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'city': cityController.text,
      'postalCode': postalCodeController.text,
      'homeAddress': homeAddressController.text,
    };

    savedAddresses.add(newAddress);
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   // Dispose focus nodes and controllers
  //   nameController.dispose();
  //   homeAddressController.dispose();
  //   emailController.dispose();
  //   phoneController.dispose();
  //   cityController.dispose();
  //   postalCodeController.dispose();

  //   super.dispose();
  // }

  // Validation logic for form fields
  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your name';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    if (!RegExp(r'^(03|04|05)[0-9]{9}$').hasMatch(value)) {
      return 'Enter a valid Pakistani phone number';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your city';
    return null;
  }

  String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your postal code';
    if (!RegExp(r'^\d{5}$').hasMatch(value)) {
      return 'Enter a valid postal code';
    }
    return null;
  }

  String? validateHomeAddress(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your home address';
    return null;
  }
}
