import 'package:flutter/material.dart';
import 'package:brand/generate/userSideModel/exploreModel.dart';

class ExploreScreenController with ChangeNotifier {
  final List<ExploreModel> _companies = [
    ExploreModel(
        name: "TechCorp", imageUrl: "https://picsum.photos/200/300?random=1"),
    ExploreModel(
        name: "ShopEasy", imageUrl: "https://picsum.photos/200/300?random=2"),
    ExploreModel(
        name: "FashionHub", imageUrl: "https://picsum.photos/200/300?random=3"),
    ExploreModel(
        name: "GadgetZone", imageUrl: "https://picsum.photos/200/300?random=4"),
    ExploreModel(
        name: "TechCorp", imageUrl: "https://picsum.photos/200/300?random=1"),
    ExploreModel(
        name: "ShopEasy", imageUrl: "https://picsum.photos/200/300?random=2"),
    ExploreModel(
        name: "FashionHub", imageUrl: "https://picsum.photos/200/300?random=3"),
    ExploreModel(
        name: "GadgetZone", imageUrl: "https://picsum.photos/200/300?random=4"),
  ];

  List<ExploreModel> get companies => List.unmodifiable(_companies);

  void addCompany(String name, String imageUrl) {
    _companies.add(ExploreModel(name: name, imageUrl: imageUrl));
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      notifyListeners();
      return;
    }
    _companies.retainWhere(
        (company) => company.name.toLowerCase().contains(query.toLowerCase()));
    notifyListeners();
  }
}
