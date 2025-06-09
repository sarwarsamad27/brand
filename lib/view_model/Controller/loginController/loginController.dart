import '../../../barrelView/barrelView.dart';

import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isObsecure = true;
  String? loginError;
  String? response;
  bool isLoading = false;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  // static Future<User?> loginUsingEmailPassword(
  //     {required String email,
  //     required String password,
  //     required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     user = userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == "user not found") {
  //       print('No user found for that email');
  //     }
  //   }
  //   return user;
  // }

  // String userEmail = "";
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  // Future<User?> handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //     final UserCredential authResult =
  //         await _auth.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //     print("Signed in: ${user!.displayName}");
  //     return user;
  //   } catch (error) {
  //     print("Error: $error");
  //     return null;
  //   }
  // }

  // Validate email using regex
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
    return emailRegex.hasMatch(email);
  }

  // Validate password (min 6 characters)
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Handle login action
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    loginError = null;
    notifyListeners();

    // Simulating network delay for login
    await Future.delayed(const Duration(seconds: 2));

    // Replace this with actual login logic (API call, etc.)
    if (isValidEmail(emailController.text) &&
        isValidPassword(passwordController.text)) {
      response = 'Login Successful';
      loginError = null;
    } else {
      response = null;
      loginError = 'Invalid email or password';
    }

    isLoading = false;
    notifyListeners();
  }

  // Dispose controllers
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

//  Future<void> loginUser() async {
//     try {
//       final dio = DioService(
//         BaseOptions(
//           baseUrl: AppBaseURLs.registerStudentURL,
//           headers: {
//             'Content-Type': 'application/json',
//           },
//           connectTimeout: const Duration(seconds: 60),
//         ),
//       );

//       final response = await dio.postRequest(
//         AppEndPoints.userLoginEndPoints,
//         {
//           'email': emailController.text,
//           'password': passwordController.text,
//         },
//       );
//       //  print(response.data['data']['user']['refreshToken']);

//       SharedPreferences sharedPreference =
//           await SharedPreferences.getInstance();

//       sharedPreference.setString(
//           'token', response.data['data']['user']['refreshToken']);

//       final String? token = sharedPreference.getString('token');

//       //      print(response.statusCode);
//       print(token);
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
}
