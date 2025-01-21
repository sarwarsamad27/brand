import 'package:brand/barrelView/barrelView.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access DashboardController via Provider
    final dashboardController = Provider.of<DashboardController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Dashboard'),
        centerTitle: true,
      ),
      body: dashboardController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardController.errorMessage != null
              ? Center(
                  child: Text(
                    dashboardController.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Revenue Card
                      _buildMetricCard(
                        title: 'Revenue',
                        value:
                            '\$${dashboardController.revenue.toStringAsFixed(2)}',
                        icon: Icons.attach_money,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 16),

                      // Total Orders Card
                      _buildMetricCard(
                        title: 'Total Orders',
                        value: '${dashboardController.totalOrders}',
                        icon: Icons.shopping_cart,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),

                      // Total Products Card
                      _buildMetricCard(
                        title: 'Total Products',
                        value: '${dashboardController.totalProducts}',
                        icon: Icons.inventory,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 16),

                      // Placeholder for Graphs/Charts
                      const Text(
                        'Revenue and Orders Overview (Graphs/Charts)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 150, child: Placeholder()),

                      // Recent Orders Section
                      const SizedBox(height: 16),
                      const Text(
                        'Recent Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 200, // Set a fixed height for ListView
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              10, // Replace with actual recent orders count
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                // Handle tap on the ListTile
                                print('Tapped on Order #${index + 1}');
                              },
                              leading: const Icon(Icons.receipt),
                              title: Text('Order #${index + 1}'),
                              subtitle:
                                  const Text('Details about the order...'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  // Widget to build metric cards
  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
