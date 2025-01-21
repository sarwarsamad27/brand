import 'package:brand/barrelView/barrelView.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Shopkeeper Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shopkeeper's Phone Number Input
            TextField(
              controller: paymentProvider.phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Enter Easypaisa Phone Number",
                hintText: "e.g., 03001234567",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Payment Button
            paymentProvider.isProcessing
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      if (paymentProvider
                          .phoneNumberController.text.isNotEmpty) {
                        // Trigger payment via provider
                        await paymentProvider.initiateEasypaisaPayment(
                          phoneNumber:
                              paymentProvider.phoneNumberController.text,
                          amount: "500", // Fixed registration fee
                        );

                        // Show result in a SnackBar
                        final snackBar = SnackBar(
                          content: Text(paymentProvider.paymentStatus ?? ''),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = const SnackBar(
                          content: Text("Please enter a valid phone number!"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text("Pay Registration Fee (500 PKR)"),
                  ),
          ],
        ),
      ),
    );
  }
}
