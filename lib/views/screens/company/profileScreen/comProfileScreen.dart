import 'package:brand/barrelView/barrelView.dart';

class ComProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile & Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Company Name: XYZ Pvt. Ltd.', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Contact: contact@xyz.com', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add logout or settings functionality
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
