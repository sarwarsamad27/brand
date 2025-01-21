class Order {
  final String id;
  final String productId;
  final String customerName;
  final String customerAddress;
  final int quantity;
  final String status; // Pending, Shipped, Delivered

  Order({
    required this.id,
    required this.productId,
    required this.customerName,
    required this.customerAddress,
    required this.quantity,
    required this.status,
  });
}
