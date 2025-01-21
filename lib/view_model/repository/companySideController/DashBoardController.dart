import 'package:brand/barrelView/barrelView.dart';

class DashboardController with ChangeNotifier {
  // Dashboard metrics
  double revenue = 0.0;
  int totalOrders = 0;
  int totalProducts = 0;

  // Loading and error states
  bool isLoading = false;
  String? errorMessage;

  // Method to update dashboard metrics
  void updateDashboard(double newRevenue, int newOrders, int newProducts) {
    revenue = newRevenue;
    totalOrders = newOrders;
    totalProducts = newProducts;
    notifyListeners(); // Notify UI to refresh
  }

  // Simulate fetching data (replace this with actual API call)
  Future<void> fetchDashboardData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners(); // Notify listeners of the loading state

    try {
      // Simulating network delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock data (replace with API response)
      updateDashboard(50000.0, 120, 50);
    } catch (error) {
      errorMessage = "Failed to load dashboard data.";
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners of the updated state
    }
  }
}
