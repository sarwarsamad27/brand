// import 'package:brand/barrelView/barrelView.dart';
// import 'package:brand/view_model/repository/companySideController/comProfileController.dart';

// class EditProfileScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<CompanyProfileProvider>(context);

//     // Controllers for form fields
//     final nameController =
//         TextEditingController(text: profileProvider.companyName);
//     final contactController =
//         TextEditingController(text: profileProvider.contactNumber);
//     final emailController = TextEditingController(text: profileProvider.email);
//     final addressController =
//         TextEditingController(text: profileProvider.address);
//     final descriptionController =
//         TextEditingController(text: profileProvider.description);
//     final hoursController =
//         TextEditingController(text: profileProvider.workingHours);

//     return Scaffold(
//       appBar: AppBar(title: Text("Edit Profile")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: "Company Name"),
//               ),
//               TextFormField(
//                 controller: contactController,
//                 decoration: InputDecoration(labelText: "Contact Number"),
//               ),
//               TextFormField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//               ),
//               TextFormField(
//                 controller: addressController,
//                 decoration: InputDecoration(labelText: "Address"),
//               ),
//               TextFormField(
//                 controller: descriptionController,
//                 decoration: InputDecoration(labelText: "Description"),
//               ),
//               TextFormField(
//                 controller: hoursController,
//                 decoration: InputDecoration(labelText: "Working Hours"),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // Save updated profile details
//                   profileProvider.updateProfile(
//                     name: nameController.text,
//                     logo:
//                         profileProvider.logoUrl, // Assume logo remains the same
//                     contact: contactController.text,
//                     emailAddress: emailController.text,
//                     companyAddress: addressController.text,
//                     companyDescription: descriptionController.text,
//                     hours: hoursController.text,
//                   );

//                   Navigator.pop(context);
//                 },
//                 child: Text("Save Changes"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AnalyticsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final profileProvider = Provider.of<CompanyProfileProvider>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text("Analytics")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Total Sales: ${profileProvider.totalSales}",
//                 style: TextStyle(fontSize: 18)),
//             Text("Pending Orders: ${profileProvider.pendingOrders}",
//                 style: TextStyle(fontSize: 18)),
//             Text("Revenue: \$${profileProvider.revenue.toStringAsFixed(2)}",
//                 style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }
// }
