import 'package:brand/barrelView/barrelView.dart';

class Profilescreencontroller extends ChangeNotifier {
  File? _selectedImage;

  File? get selectedImage => _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> captureImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  // Future<void> pickResume() async {
  //   if (_isPicking) return;
  //   _isPicking = true;

  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
  //     );
  //     if (result != null) {
  //       resumeName = result.files.single.name;
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print("Error picking Resume: $e");
  //   } finally {
  //     _isPicking = false;
  //   }
  // }
}
