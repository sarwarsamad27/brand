import 'package:brand/barrelView/barrelView.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formController = Provider.of<Orderformcontroller>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Addresses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: formController.savedAddresses.isEmpty
            ? const Center(
                child: Text("No addresses saved."),
              )
            : ListView.builder(
                itemCount: formController.savedAddresses.length,
                itemBuilder: (context, index) {
                  final address = formController.savedAddresses[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${address['name']}"),
                          Text("Email: ${address['email']}"),
                          Text("Phone: ${address['phone']}"),
                          Text("City: ${address['city']}"),
                          Text("Postal Code: ${address['postalCode']}"),
                          Text("Home Address: ${address['homeAddress']}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => FavouriteOrderFormScreen(
                      selectedProducts: [],
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
