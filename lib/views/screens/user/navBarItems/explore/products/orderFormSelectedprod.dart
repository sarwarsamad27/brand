import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/companySideModels/orderModels.dart';
import 'package:brand/view_model/Controller/companySideController/comOrderController.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';
import 'package:brand/views/widget/customAppbar.dart';

class OrderFormSelectedProd extends StatelessWidget {
  final List<CompanyProducts> selectedProducts;

  const OrderFormSelectedProd({super.key, required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    final orderController = Provider.of<OrderController>(context);

    return ChangeNotifierProvider(
      create: (_) => ComProductDetailController(),
      child: Consumer<Orderformcontroller>(
        builder: (context, formController, child) {
          final productDetailController =
              Provider.of<ComProductDetailController>(context);

          final displayedProducts = selectedProducts.isNotEmpty
              ? selectedProducts
              : productDetailController.selectedProduct != null
                  ? [productDetailController.selectedProduct!]
                  : [];

          return SafeArea(
            child: Scaffold(
              appBar: modernAppBar(context,
                  name: 'Your Special Product', detail: 'fill form correct'),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (displayedProducts.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Card(
                              elevation: 2,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: displayedProducts.length,
                                itemBuilder: (context, index) {
                                  final product = displayedProducts[index];
                                  return ListTile(
                                    leading: Image.file(
                                      File(product.images[0]),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error,
                                                  color: Colors.red),
                                    ),
                                    title: Text(product.name),
                                    subtitle: Text(
                                        'Price: ${product.price.toStringAsFixed(2)}'),
                                  );
                                },
                              ),
                            ),
                            const Divider(height: 32),
                          ],
                        ),

                      // Name Field
                      CustomTextField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          controller: formController.nameController,
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Name',
                          validator: formController.validateName),

                      const SizedBox(height: 16),

                      // Email Field
                      CustomTextField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          controller: formController.emailController,
                          prefixIcon: const Icon(Icons.email),
                          hintText: 'Email',
                          validator: formController.validateEmail),

                      const SizedBox(height: 16),

                      // Phone Number Field
                      CustomTextField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          controller: formController.phoneController,
                          prefixIcon: const Icon(Icons.phone),
                          hintText: '+92322-0270729',
                          validator: formController.validatePhone),

                      const SizedBox(height: 16),

                      // City Field
                      CustomTextField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          controller: formController.cityController,
                          prefixIcon: const Icon(Icons.location_city),
                          hintText: 'City',
                          validator: formController.validateCity),

                      const SizedBox(height: 16),

                      // Postal Code Field
                      CustomTextField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          controller: formController.postalCodeController,
                          prefixIcon: const Icon(Icons.local_post_office),
                          hintText: 'Postal Code',
                          validator: formController.validatePostalCode),

                      const SizedBox(height: 16),

                      // Home Address Field
                      CustomTextField(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          controller: formController.homeAddressController,
                          prefixIcon: const Icon(Icons.home),
                          hintText: 'Home Address',
                          validator: formController.validateHomeAddress),

                      const SizedBox(height: 24),

                      // Submit Button
                      CustomButton(
                        onTap: () {
                          // if (
                          // formController.formKey.currentState!
                          //   .validate()
                          // ) {
                          // Create a new customer order
                          final customerOrder = CustomerOrder(
                            id: DateTime.now().toString(),
                            customerName: formController.nameController.text,
                            customerAddress:
                                formController.homeAddressController.text,
                            products: selectedProducts,
                            status: 'Pending', // Default status
                          );

                          // Convert CustomerOrder to Order
                          final order = convertToOrder(customerOrder);

                          // Add the order to the OrderController
                          orderController.addOrder(order);

                          // Clear the cart and navigate back
                          productDetailController.clearCart();
                          Navigator.pop(context);
                        },
                        // },
                        child: const Text("Place Order"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Order convertToOrder(CustomerOrder customerOrder) {
    // Assuming `products` in CustomerOrder is a list of CompanyProduct
    // and each CompanyProduct has an `id` and `quantity` field.
    // If not, adjust the logic accordingly.

    // Calculate total quantity of products in the order
    int totalQuantity = customerOrder.products
        .fold(0, (sum, product) => sum + product.quantity);

    // Extract product IDs (if needed)
    String productIds =
        customerOrder.products.map((product) => product.id).join(', ');

    return Order(
      customerName: customerOrder.customerName,
      customerAddress: customerOrder.customerAddress,
      productId: productIds, // Concatenated product IDs
      quantity: totalQuantity, id: customerOrder.id,
      status: customerOrder.status, // Total quantity of all products
    );
  }
}
