import 'package:brand/barrelView/barrelView.dart';

class CustomLogoutAlert extends StatelessWidget {
  const CustomLogoutAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutRepo = Provider.of<LogoutRepository>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColor.whiteColor,
          title: Center(
            child: Column(
              children: [
                Image.asset(
                  Assets.alertLogout,
                  width: 30,
                ),
                const SizedBox(
                  height: 7,
                ),
                const CustomText(
                  text: "Logging out",
                  style: TextStyle(
                      fontSize: AppFontSizes.font18,
                      fontWeight: AppFontWeight.w500),
                )
              ],
            ),
          ),
          // content: Text('Are you sure you want to log out?'),
          content: SizedBox(
            height: 38,
            // width: 300,
            width: constraints.maxWidth * 1,
            child: const Column(
              children: [
                Divider(),
                CustomText(
                  text: 'Are you sure you want to log out?',
                  style: TextStyle(color: AppColor.textPrimaryLightColor),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // TextButton(
                //   onPressed: _hideLogoutDialog,
                //   child: Text('Cancel'),
                // ),
                InkWell(
                  onTap: logoutRepo.hideLogoutDialog,
                  child: Container(
                    height: 38,
                    width: constraints.maxWidth * 0.3,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.textPrimaryColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: CustomText(
                        text: "Cancel",
                        style: TextStyle(color: AppColor.textPrimaryColor),
                      ),
                    ),
                  ),
                ),
                // TextButton(
                //   onPressed: _logout,
                //   child: Text('Logout'),
                // ),
                InkWell(
                  // onTap: logoutRepo.logout,
                  onTap: () {
                    logoutRepo.logout();
                    Navigator.pushNamed(context, RoutesName.loginScreen);
                  },
                  child: Container(
                    height: 38,
                    width: constraints.maxWidth * 0.3,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: CustomText(
                        text: "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
