import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/companySideController/comloginController.dart';
import 'package:brand/view_model/Controller/companySideController/compFormController.dart';
import 'package:brand/views/widget/customAppbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComFormScreen extends StatefulWidget {
  const ComFormScreen({super.key});

  @override
  _ComFormScreenState createState() => _ComFormScreenState();
}

class _ComFormScreenState extends State<ComFormScreen> {
  @override
  void initState() {
    super.initState();
    _checkFormSubmission();
  }

  Future<void> _checkFormSubmission() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFormSubmitted = prefs.getBool('formSubmitted') ?? false;

    if (isFormSubmitted) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, RoutesName.compHomeScreen);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final comploginFormController = Provider.of<CompLoginController>(context);
    final comFormController = Provider.of<CompanyFormController>(context);

    final height = MediaQuery.of(context).size.height * 1;

    if (comFormController.isFormSubmitted) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamed(context, RoutesName.compHomeScreen);
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
            SizedBox(height: height * .07),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
              readOnly: true,
              controller: comploginFormController.comEmailController,
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
              prefixIcon: const Icon(Icons.home),
              hintText: 'Company Description',
              labelText: 'Description',
              controller: comFormController.descriptionController,
            ),
            SizedBox(height: height * .04),
            CustomButton(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();

                await prefs.setString(
                    'companyName', comFormController.nameController.text);
                await prefs.setString(
                    'companyContact', comFormController.contactController.text);
                await prefs.setString(
                    'companyAddress', comFormController.addressController.text);
                await prefs.setString('companyDescription',
                    comFormController.descriptionController.text);
                await prefs.setString('companyEmail',
                    comploginFormController.comEmailController.text);

                if (comFormController.selectedImage != null) {
                  await prefs.setString(
                      'companyImage', comFormController.selectedImage!.path);
                }

                await prefs.setBool('formSubmitted', true);

                if (mounted) {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.compHomeScreen);
                }
              },
              child: const Text("Submit",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )
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
