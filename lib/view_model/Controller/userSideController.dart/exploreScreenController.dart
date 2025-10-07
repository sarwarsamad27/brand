import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/userSideModel/exploreModel.dart';
import 'package:brand/view_model/Repository/UserRepository/explore_repository.dart';

class ExploreScreenController with ChangeNotifier {
  List<Profiles> _allProfiles = []; // original data
  List<Profiles> _companies = []; // filtered list
  List<Profiles> get companies => _companies;
  List<Profiles> get filteredProfiles => _companies;
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> loadExplore({String name = "", String image = ""}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await ExploreRepository.fetchUserExplore(name, image);

      if (result.profiles != null && result.profiles!.isNotEmpty) {
        _allProfiles = result.profiles!;
        _companies = _allProfiles; // 👈 dono sync
        _errorMessage = '';
      } else {
        _allProfiles = [];
        _companies = [];
        _errorMessage = 'No profiles found';
      }
    } catch (e) {
      _errorMessage = "Error: $e";
      _allProfiles = [];
      _companies = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    _companies = _allProfiles;
    notifyListeners();
  }

  void searchProfiles(String query) {
    if (query.isEmpty) {
      _companies = _allProfiles;
    } else {
      _companies = _allProfiles.where((profile) {
        final name = (profile.name ?? "").toLowerCase();
        final email = (profile.email ?? "").toLowerCase();
        return name.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
