import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/repository/userSideController.dart/themeController.dart';
import 'package:brand/views/screens/user/navBarItems/profile/address/address.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileScreenController =
        Provider.of<Profilescreencontroller>(context);
    final themeManager = Provider.of<ThemeManager>(context);
    final logoutRepo = Provider.of<LogoutRepository>(context);
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Column(children: [
          CustomContainer(
              height: height * .14,
              width: width * .3,
              borderColor: AppColor.primaryColor,
              onTap: () {
                profileScreenController.captureImageFromCamera();
              },
              child: ClipOval(
                  child: profileScreenController.selectedImage != null
                      ? Image.file(
                          profileScreenController.selectedImage!,
                          fit: BoxFit.fill,
                        )
                      : const Icon(Icons.person))),
          SizedBox(
            height: height * .035,
          ),
          Text(
            'Sarwar samad',
            style: TextStyle(fontSize: height * .035),
          ),
          SizedBox(
            height: height * .04,
          ),
          CustomContainer(
            width: width * 1,
            height: height * .05,
            bgColor: AppColor.dialogBgColor,
            onTap: () {
              Navigator.pushNamed(context, RoutesName.messageScreen);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.message),
                  SizedBox(
                    width: width * .01,
                  ),
                  const Text('Messages'),
                  SizedBox(
                    width: width * .58,
                  ),
                  SvgPicture.asset(
                    Assets.arrowForward,
                    color: Colors.black,
                    height: height * .017,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .03,
          ),
          CustomContainer(
            width: width * 1,
            height: height * .05,
            bgColor: AppColor.dialogBgColor,
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.gif_box),
                  SizedBox(
                    width: width * .01,
                  ),
                  const Text('Orders'),
                  SizedBox(
                    width: width * .63,
                  ),
                  SvgPicture.asset(
                    Assets.arrowForward,
                    color: Colors.black,
                    height: height * .017,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .03,
          ),
          CustomContainer(
            width: width * 1,
            height: height * .05,
            bgColor: AppColor.dialogBgColor,
            onTap: () {
              Navigator.pushNamed(context, RoutesName.termAndConditionScreen);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.privacy_tip_outlined),
                  SizedBox(
                    width: width * .01,
                  ),
                  const Text('Term and condition'),
                  SizedBox(
                    width: width * .43,
                  ),
                  SvgPicture.asset(
                    Assets.arrowForward,
                    color: Colors.black,
                    height: height * .017,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .03,
          ),
          CustomContainer(
            width: width * 1,
            height: height * .05,
            bgColor: AppColor.dialogBgColor,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddressScreen()));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.location_on),
                  SizedBox(
                    width: width * .01,
                  ),
                  const Text('Address'),
                  SizedBox(
                    width: width * .6,
                  ),
                  SvgPicture.asset(
                    Assets.arrowForward,
                    color: Colors.black,
                    height: height * .017,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .03,
          ),
          CustomContainer(
            width: width * 1,
            height: height * .05,
            bgColor: AppColor.dialogBgColor,
            onTap: () {
              showThemeBottomSheet(context, themeManager);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.light_mode),
                  SizedBox(
                    width: width * .01,
                  ),
                  const Text('Theme'),
                  SizedBox(
                    width: width * .6,
                  ),
                  SvgPicture.asset(
                    Assets.arrowForward,
                    color: Colors.black,
                    height: height * .017,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * .03,
          ),
          CustomContainer(
            width: width * 1,
            height: height * .05,
            bgColor: AppColor.dialogBgColor,
            onTap: () {
              logoutRepo.showLogoutDialog();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.logout_sharp),
                  SizedBox(
                    width: width * .01,
                  ),
                  const Text('Log out'),
                  SizedBox(
                    width: width * .6,
                  ),
                  SvgPicture.asset(
                    Assets.arrowForward,
                    color: Colors.black,
                    height: height * .017,
                  ),
                ],
              ),
            ),
          ),
        ]),
        if (logoutRepo.isLogoutDialogVisible)
          const Opacity(
            opacity: 0.5,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (logoutRepo.isLogoutDialogVisible)
          const Center(
            child: CustomLogoutAlert(),
          ),
      ],
    )));
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
