import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/companySideController/compFormController.dart';
import 'package:brand/views/widget/Customprofilewidget.dart';
import 'package:brand/views/widget/customAppbar.dart';

class CompanyProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final comFormController = Provider.of<CompanyFormController>(context);
    final comploginFormController = Provider.of<LoginController>(context);
    final comDashboardController = Provider.of<DashboardController>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      appBar: modernAppBar(context, name: 'Profile', detail: 'screen'),
      body: Stack(
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
              // Static Content (Stays in place)
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
                          backgroundImage:
                              comFormController.selectedImage != null
                                  ? FileImage(comFormController.selectedImage!)
                                  : null,
                          child: comFormController.selectedImage == null
                              ? const Icon(Icons.camera_alt,
                                  size: 40, color: Colors.black54)
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildProfileInfo(
                        "Company Name", comFormController.nameController.text),
                    buildProfileInfo("Description",
                        comFormController.descriptionController.text),
                    buildProfileInfo(
                        "Email", comploginFormController.emailController.text),
                    buildProfileInfo(
                        "Phone", comFormController.contactController.text),
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
                        _buildFeedbackTile("Michael Johnson",
                            "Fast delivery and excellent support!", 5),
                        _buildFeedbackTile("Emily Brown",
                            "Satisfied with my purchase. Will buy again.", 4),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
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


//For dynamic function
              // Scrollable Content
//              Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: width * .05),
//                   child: ListView.builder(
//                     itemCount: comFormController.feedbackList.length,
//                     itemBuilder: (context, index) {
//                       final feedback = comFormController.feedbackList[index];
//                       return Card(
//                         elevation: 3,
//                         margin: const EdgeInsets.symmetric(vertical: 8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(feedback.userName,
//                                   style: TextStyle(
//                                       fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
//                               SizedBox(height: 5),
//                               Text(feedback.comment, style: TextStyle(fontSize: 14)),
//                               SizedBox(height: 5),
//                               Row(
//                                 children: List.generate(
//                                   feedback.rating,
//                                   (index) => Icon(Icons.star, color: Colors.amber, size: 16),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }


//   Widget _buildStatTile(String title, String value) {
//     return Card(
//       elevation: 2,
//       child: ListTile(
//         title: Text(title,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//         trailing: Text(value,
//             style: const TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
//       ),
//     );
//   }
// }
