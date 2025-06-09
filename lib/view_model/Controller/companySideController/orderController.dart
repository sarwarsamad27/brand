import 'package:brand/barrelView/barrelView.dart';

class OrderController with ChangeNotifier {
  List<Order> _orders = [
    // Dummy data
    Order(
      id: '1',
      productId: '101',
      customerName: 'John Doe',
      customerAddress: '123 Main Street',
      quantity: 3,
      status: 'Pending',
    ),
    Order(
      id: '2',
      productId: '102',
      customerName: 'Jane Smith',
      customerAddress: '456 Elm Avenue',
      quantity: 5,
      status: 'Shipped',
    ),
  ];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String status) {
    int index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index] = Order(
        id: _orders[index].id,
        productId: _orders[index].productId,
        customerName: _orders[index].customerName,
        customerAddress: _orders[index].customerAddress,
        quantity: _orders[index].quantity,
        status: status,
      );
      notifyListeners();
    }
  }
}
