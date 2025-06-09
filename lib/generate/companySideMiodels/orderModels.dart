import 'package:brand/generate/companySideMiodels/comSideProductModel.dart';

class CustomerOrder {
  final String id;
  final String customerName;
  final String customerAddress;
  final List<CompanyProducts> products;
  String status;

  CustomerOrder({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.products,
    this.status = 'Pending',
  });
}
