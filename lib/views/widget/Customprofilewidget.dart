import 'package:brand/barrelView/barrelView.dart';

Widget buildProfileInfo(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Text(value,
            style: const TextStyle(fontSize: 16, color: Colors.black87)),
      ],
    ),
  );
}
