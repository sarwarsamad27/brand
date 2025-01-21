import 'package:brand/barrelView/barrelView.dart';

class ExploreScreenController extends ChangeNotifier {
  // All brands list
  final List<String> _allBrands =
      List.generate(10, (index) => 'Brand Name $index');

  // Filtered brands for the search functionality
  List<String> _filteredBrands = [];

  ExploreScreenController() {
    _filteredBrands = _allBrands; // Initialize filtered brands
  }

  List<String> get filteredBrands => _filteredBrands;

  void filterBrands(String query) {
    if (query.isEmpty) {
      _filteredBrands = _allBrands;
    } else {
      _filteredBrands = _allBrands
          .where((brand) => brand.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify the UI to rebuild
  }
}
