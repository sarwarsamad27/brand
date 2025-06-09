import 'package:brand/barrelView/barrelView.dart';

class Company {
  final String name;
  final String address;
  final String email;
  final String contact;
  final File? image;

  Company({
    required this.name,
    required this.address,
    required this.email,
    required this.contact,
    this.image,
  });
}
