import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/views/screens/user/navBarItems/profile/address/address.dart';
import 'package:brand/views/screens/user/navBarItems/profile/myOrders/myOrderScreen.dart';
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
      appBar: modernAppBar(
        context,
        name: 'Profile',
        detail: 'Check your profile',
      ),
      body: ScaleFadeAnimation(
        delay: 2,
        child: Stack(
          children: [
            // 🔹 Gradient Background

            // 🔹 Content
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * .06),

                  // Avatar with Glow
                  // Avatar with Glow
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFDF762E),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: userFormController.selectedImage != null
                          ? FileImage(userFormController.selectedImage!)
                          : const AssetImage('assets/images/imageIcon.webp')
                              as ImageProvider,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 🔹 Profile Options
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildProfileOption(
                          Icons.message_rounded,
                          "Messages",
                          width,
                          () => Navigator.pushNamed(
                              context, RoutesName.messageScreen),
                        ),
                        _buildProfileOption(
                            Icons.shopping_bag_rounded, "My Orders", width, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyOrderScreen(),
                            ),
                          );
                        }),
                        _buildProfileOption(
                          Icons.privacy_tip_rounded,
                          "Terms & Conditions",
                          width,
                          () => Navigator.pushNamed(
                              context, RoutesName.termAndConditionScreen),
                        ),
                        _buildProfileOption(
                          Icons.location_on_rounded,
                          "Address",
                          width,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddressScreen(),
                              ),
                            );
                          },
                        ),
                        _buildProfileOption(
                          Icons.location_on_rounded,
                          "Logout",
                          width,
                          () {
                            logoutRepo.logout(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 Logout Overlay
            if (logoutRepo.isLogoutDialogVisible)
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.black,
                ),
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Color(0xFFDF762E)),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.black54),
            ],
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
