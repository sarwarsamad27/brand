import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/companySideController/comProfileController.dart';
import 'package:brand/view_model/Controller/companySideController/compFormController.dart';
import 'package:brand/views/widget/customAppbar.dart';
import 'package:brand/views/widget/Customprofilewidget.dart';

class CompanyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comFormController = Provider.of<CompanyFormController>(context);
    final comProfileController = Provider.of<ComProfileController>(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // ✅ Email from form controller
    final email = comFormController.emailController.text.trim();

    // ✅ API call agar pehle nahi hui
    if (comProfileController.profileModel == null &&
        !comProfileController.isLoading &&
        email.isNotEmpty) {
      Future.microtask(() => comProfileController.fetchProfile(email));
    }

    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      appBar: modernAppBar(context, name: 'Profile', detail: 'screen'),
      body: Consumer<ComProfileController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          if (controller.profileModel?.profile == null) {
            return const Center(child: Text("No Profile Found ❌"));
          }

          final profile = controller.profileModel!.profile!;

          return Stack(
            children: [
              Positioned.fill(
                top: 10,
                left: 10,
                right: 10,
                bottom: height * .7,
                child: Image.asset(
                  'assets/images/imageIcon.webp',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * .02),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: profile.image != null
                                  ? NetworkImage(profile.image!)
                                  : null,
                              child: profile.image == null
                                  ? const Icon(Icons.camera_alt,
                                      size: 40, color: Colors.black54)
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildProfileInfo("Company Name", profile.name ?? ""),
                        buildProfileInfo(
                            "Description", profile.description ?? ""),
                        buildProfileInfo("Email", profile.email ?? ""),
                        buildProfileInfo("Phone", profile.mobile ?? ""),
                        buildProfileInfo("Address", profile.address ?? ""),
                        const Text("Feedback from Customer",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const Divider(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .05),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildFeedbackTile("John Doe",
                                "Great service! Highly recommended.", 5),
                            _buildFeedbackTile("Jane Smith",
                                "Good quality products but a bit pricey.", 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFeedbackTile(String name, String comment, int rating) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            SizedBox(height: 5),
            Text(comment, style: TextStyle(fontSize: 14)),
            SizedBox(height: 5),
            Row(
              children: List.generate(
                rating,
                (index) => Icon(Icons.star, color: Colors.amber, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
