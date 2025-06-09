import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/views/screens/user/navBarItems/profile/address/address.dart';
import 'package:brand/views/widget/customAppbar.dart';
import 'package:brand/views/widget/customContainerAnimation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final userFormController = Provider.of<ProfileScreenController>(context);
    final logoutRepo = Provider.of<LogoutRepository>(context);

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.appbackgroundcolor,
      appBar:
          modernAppBar(context, name: 'Profile', detail: 'Check your profile'),
      body: ScaleFadeAnimation(
        delay: 2,
        child: Stack(
          children: [
            Positioned.fill(
              top: 10,
              left: 10,
              right: 10,
              bottom: height * .63,
              child: Image.asset(
                'assets/images/imageIcon.webp',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .05,
                ),
                Container(
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
                    backgroundImage: userFormController.selectedImage != null
                        ? FileImage(userFormController.selectedImage!)
                        : null,
                    child: userFormController.selectedImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Colors.black54)
                        : null,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  userFormController.nameController.text,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildProfileOption(Icons.message, "Messages", width, () {
                  Navigator.pushNamed(context, RoutesName.messageScreen);
                }),
                _buildProfileOption(Icons.gif_box, "Orders", width, () {}),
                _buildProfileOption(
                    Icons.privacy_tip_outlined, "Terms and Conditions", width,
                    () {
                  Navigator.pushNamed(
                      context, RoutesName.termAndConditionScreen);
                }),
                _buildProfileOption(Icons.location_on, "Address", width, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddressScreen()));
                }),
                _buildProfileOption(Icons.light_mode, "Theme", width, () {
                  showThemeBottomSheet(context, themeManager);
                }),
                _buildProfileOption(Icons.logout_sharp, "Log out", width, () {
                  logoutRepo.showLogoutDialog();
                }),
              ],
            ),
            if (logoutRepo.isLogoutDialogVisible)
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (logoutRepo.isLogoutDialogVisible)
              const Center(child: CustomLogoutAlert()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      IconData icon, String title, double width, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: width * 0.9,
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.dialogBgColor,
          border:
              Border.all(color: AppColor.appimagecolor), // Added black border
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColor.appimagecolor),
                    const SizedBox(width: 10),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
                SvgPicture.asset(
                  Assets.arrowForward,
                  color: Colors.black,
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showThemeBottomSheet(BuildContext context, ThemeManager themeManager) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Theme",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text("Light Theme"),
              onTap: () {
                themeManager.setTheme(ThemeMode.light);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Dark Theme"),
              onTap: () {
                themeManager.setTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_suggest),
              title: const Text("System Default"),
              onTap: () {
                themeManager.setTheme(ThemeMode.system);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
