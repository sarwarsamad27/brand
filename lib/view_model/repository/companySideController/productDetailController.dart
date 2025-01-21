import 'package:brand/barrelView/barrelView.dart';

class ComProductDetailController with ChangeNotifier {
  int currentIndex = 0;
  late final PageController pageController;

  ComProductDetailController() {
    pageController = PageController(initialPage: currentIndex);
  }

  // Method to set the current image index
  void setImageIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  // Method to move to the next image
  void goToNextImage(int totalImages) {
    if (currentIndex < totalImages - 1) {
      currentIndex++;
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  // Method to move to the previous image
  void goToPreviousImage() {
    if (currentIndex > 0) {
      currentIndex--;
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }
}
