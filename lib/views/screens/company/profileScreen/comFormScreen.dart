import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/companySideController/compFormController.dart';
import 'package:brand/views/widget/customAppbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComFormScreen extends StatelessWidget {
  const ComFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final comFormController = Provider.of<CompanyFormController>(context);
    final height = MediaQuery.of(context).size.height;

    if (comFormController.isFormSubmitted) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, RoutesName.compHomeScreen);
      });
    }

    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      appBar: modernAppBar(context,
          name: 'Company Profile', detail: 'Complete your details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!comFormController.isFormSubmitted)
              SizedBox(height: height * .07),

            /// Company logo
            GestureDetector(
              onTap: () => showImagePickerOptions(context, comFormController),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[300],
                backgroundImage: comFormController.selectedImage != null
                    ? FileImage(comFormController.selectedImage!)
                    : null,
                child: comFormController.selectedImage == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt,
                              size: 40, color: Colors.black54),
                          Text('Company Logo')
                        ],
                      )
                    : null,
              ),
            ),

            SizedBox(height: height * .04),

            /// Form fields
            CustomTextField(
              hintText: 'Company Name',
              labelText: 'Company Name',
              prefixIcon: const Icon(Icons.person),
              controller: comFormController.nameController,
            ),
            SizedBox(height: height * .02),

            CustomTextField(
              prefixIcon: const Icon(Icons.email_outlined),
              labelText: 'Company Email',
              controller: comFormController.emailController,
            ),
            SizedBox(height: height * .02),

            CustomTextField(
              prefixIcon: Icon(FontAwesomeIcons.phone, size: height * .025),
              hintText: 'Enter Company Mobile Number',
              labelText: 'Mobile Number',
              controller: comFormController.contactController,
            ),
            SizedBox(height: height * .02),

            CustomTextField(
              prefixIcon: const Icon(Icons.home),
              hintText: 'Company Address',
              labelText: 'Address',
              controller: comFormController.addressController,
            ),
            SizedBox(height: height * .02),

            CustomTextField(
              prefixIcon: const Icon(Icons.description),
              hintText: 'Company Description',
              labelText: 'Description',
              controller: comFormController.descriptionController,
            ),

            SizedBox(height: height * .04),

            /// Submit Button
            comFormController.isLoading
                ? const CircularProgressIndicator(color: AppColor.appimagecolor)
                : CustomButton(
                    onTap: () {
                      comFormController
                          .registerCompanyForm(context)
                          .then((res) {
                        if (res != null && res.profile != null) {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.compHomeScreen);
                        }
                      });
                    },
                    child: const Text(
                      "Submit",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void showImagePickerOptions(
      BuildContext context, CompanyFormController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Take a photo"),
              onTap: () {
                controller.captureImage();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Choose from gallery"),
              onTap: () {
                controller.pickImage();
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
