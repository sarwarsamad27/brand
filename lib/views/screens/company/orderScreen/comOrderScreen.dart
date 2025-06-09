import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/companySideController/comOrderController.dart';

class ComOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderController = Provider.of<OrderController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: orderController.orders.isEmpty
          ? const Center(
              child: Text(
                'No orders available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: orderController.orders.length,
              itemBuilder: (context, index) {
                final order = orderController.orders[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Order #${order.id} - ${order.customerName}'),
                    subtitle: Text(
                        '${order.quantity} items - Address: ${order.customerAddress}'),
                    trailing: DropdownButton<String>(
                      value: order.status,
                      items: ['Pending', 'Shipped', 'Delivered']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (newStatus) {
                        if (newStatus != null) {
                          orderController.updateOrderStatus(
                              order.id, newStatus);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
