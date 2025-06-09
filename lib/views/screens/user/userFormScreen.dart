import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/views/widget/customAppbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserFormScreen extends StatelessWidget {
  const UserFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userFormController = Provider.of<ProfileScreenController>(context);
    final userloginFormController = Provider.of<LoginController>(context);
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      appBar: modernAppBar(context,
          detail: 'complete your detail', name: 'User Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: Column(
          children: [
            SizedBox(height: height * .07),
            GestureDetector(
              onTap: () => showImagePickerOptions(context, userFormController),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[300],
                backgroundImage: userFormController.selectedImage != null
                    ? FileImage(userFormController.selectedImage!)
                    : null,
                child: userFormController.selectedImage == null
                    ? Icon(Icons.camera_alt, size: 40, color: Colors.black54)
                    : null,
              ),
            ),
            SizedBox(height: height * .04),
            CustomTextField(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Enter your Name',
              labelText: 'Name',
              prefixIcon: Icon(Icons.person),
              txtColor: AppColor.blackcolor,
              controller: userFormController.nameController,
            ),
            SizedBox(height: height * .02),
            CustomTextField(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Email',
              readOnly: true,
              txtColor: AppColor.blackcolor,
              controller: userloginFormController.emailController,
            ),
            SizedBox(height: height * .02),
            CustomTextField(
              prefixIcon: Icon(FontAwesomeIcons.phone, size: height * .025),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: 'Enter your mobile number',
              labelText: 'Mobile Number',
              txtColor: AppColor.blackcolor,
              controller: userFormController.mobileController,
            ),
            SizedBox(height: height * .02),
            CustomTextField(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: Icon(Icons.home),
              hintText: 'Enter your Address',
              labelText: 'Address',
              txtColor: AppColor.blackcolor,
              controller: userFormController.addressController,
            ),
            SizedBox(height: height * .04),
            CustomButton(
              onTap: () {
                if (userFormController.validateForm()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Form Submitted!")));
                  Navigator.pushNamed(context, RoutesName.onBoardScreen);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill all required fields.")));
                }
              },
              child: const Text("Submit",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void showImagePickerOptions(
      BuildContext context, ProfileScreenController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Take a photo"),
              onTap: () {
                controller.captureImageFromCamera();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Choose from gallery"),
              onTap: () {
                controller.pickImageFromGallery();
                Navigator.pop(context);
              },
            ),
            if (controller.selectedImage != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Remove Image"),
                onTap: () {
                  controller.clearImage();
                  Navigator.pop(context);
                },
              ),
          ],
        );
      },
    );
  }
}
