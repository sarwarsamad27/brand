import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart'; // For the chart
import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/views/widget/customAppbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access DashboardController via Provider
    final dashboardController = Provider.of<DashboardController>(context);

    // Sample data for the bar chart
    final List<BarChartGroupData> barChartData = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 3,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8), // Rounded corners
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1), // Shading effect
            ),
          )
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 1,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          )
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 4,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          )
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 2,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          )
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
              toY: 5,
              gradient: _getBarGradient(),
              width: 20,
              borderRadius: BorderRadius.circular(8),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 10,
                color: Colors.grey.withOpacity(0.1),
              )),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            toY: 3,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            toY: 4,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          )
        ],
      ),
      BarChartGroupData(
        x: 7,
        barRods: [
          BarChartRodData(
            toY: 6,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 8,
        barRods: [
          BarChartRodData(
            toY: 3,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 9,
        barRods: [
          BarChartRodData(
            toY: 2,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 10,
        barRods: [
          BarChartRodData(
            toY: 5,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 11,
        barRods: [
          BarChartRodData(
            toY: 7,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 12,
        barRods: [
          BarChartRodData(
            toY: 8,
            gradient: _getBarGradient(),
            width: 20,
            borderRadius: BorderRadius.circular(8),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
        ],
      ),
    ];

    // Calculate the width of the chart based on the number of data points
    final double chartWidth = barChartData.length * 60.0;

    return Scaffold(
      appBar:
          modernAppBar(context, detail: 'Dashboard', name: 'Business Detail'),
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

                      // Revenue and Orders Bar Chart
                      const Text(
                        'Revenue and Orders Overview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 250, // Fixed height for the chart
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width:
                                chartWidth, // Dynamic width based on data points
                            child: BarChart(
                              BarChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: 2,
                                  getDrawingHorizontalLine: (value) {
                                    return FlLine(
                                      color: Colors.grey.withOpacity(0.3),
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          '${value.toInt()}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          '${value.toInt()}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    left: BorderSide(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                barGroups: barChartData,
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 10,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Recent Orders Section
                      const SizedBox(height: 16),
                      const Text(
                        'Recent Orders',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200, // Set a fixed height for ListView
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                              10, // Replace with actual recent orders count
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                onTap: () {
                                  // Handle tap on the ListTile
                                  print('Tapped on Order #${index + 1}');
                                },
                                leading: const Icon(Icons.receipt),
                                title: Text('Order #${index + 1}'),
                                subtitle:
                                    const Text('Details about the order...'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
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

  // Helper function to create a gradient for the bars
  LinearGradient _getBarGradient() {
    return LinearGradient(
      colors: [
        const Color(0xFFDF762E), // Darker shade
        const Color(0xFFFFA858), // Lighter shade
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }
}
