import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/companySideModels/orderModels.dart';
import 'package:brand/view_model/Controller/companySideController/comOrderController.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';
import 'package:brand/views/widget/customAppbar.dart';

class OrderFormScreen extends StatelessWidget {
  final List<CompanyProducts> selectedProducts;

  OrderFormScreen({super.key, required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    final orderFormController = Provider.of<Orderformcontroller>(context);
    final productDetailController =
        Provider.of<ComProductDetailController>(context);
    final orderController = Provider.of<OrderController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: modernAppBar(context,
            name: "Your Selected Products", detail: 'fill your form correctly'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display Selected Products
                if (selectedProducts.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Selected Products:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: selectedProducts.length,
                        itemBuilder: (context, index) {
                          final product = selectedProducts[index];
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: product.images.isNotEmpty
                                  ? Image.file(
                                      File(product.images[0]),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error,
                                                  color: Colors.red),
                                    )
                                  : const Icon(Icons.image,
                                      size: 50, color: Colors.grey),
                              title: Text(product.name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.description),
                                  Text(
                                    'Quantity: ${product.quantity}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 32),
                    ],
                  ),

                // Name Field
                CustomTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    controller: orderFormController.nameController,
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Name',
                    focusNode: orderFormController.nameFocusNode,
                    validator: orderFormController.validateName),

                const SizedBox(height: 16),

                // Email Field
                CustomTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    controller: orderFormController.emailController,
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    focusNode: orderFormController.emailFocusNode,
                    validator: orderFormController.validateEmail),

                const SizedBox(height: 16),

                // Phone Number Field
                CustomTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    controller: orderFormController.phoneController,
                    prefixIcon: const Icon(Icons.phone),
                    hintText: '+92322-0270729',
                    focusNode: orderFormController.phoneFocusNode,
                    validator: orderFormController.validatePhone),

                const SizedBox(height: 16),

                // Country Dropdown
                CustomDropdown(
                  items: orderFormController.countryList,
                  selectedItem: orderFormController.selectedCountry,
                  onChanged: (value) {
                    orderFormController.dropDownChangeValue(value);
                  },
                  isExpanded: true,
                  itemLabelBuilder: (String value) => value,
                ),

                const SizedBox(height: 16),

                // City Field
                CustomTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    controller: orderFormController.cityController,
                    prefixIcon: const Icon(Icons.location_city),
                    hintText: 'City',
                    focusNode: orderFormController.cityFocusNode,
                    validator: orderFormController.validateCity),

                const SizedBox(height: 16),

                // Postal Code Field
                CustomTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    controller: orderFormController.postalCodeController,
                    prefixIcon: const Icon(Icons.local_post_office),
                    hintText: 'Postal Code',
                    focusNode: orderFormController.postalCodeFocusNode,
                    validator: orderFormController.validatePostalCode),

                const SizedBox(height: 16),

                // Home Address Field
                CustomTextField(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    controller: orderFormController.homeAddressController,
                    prefixIcon: const Icon(Icons.home),
                    hintText: 'Home Address',
                    focusNode: orderFormController.homeAddressFocusNode,
                    validator: orderFormController.validateHomeAddress),

                const SizedBox(height: 24),

                // Submit Button
                CustomButton(
                  onTap: () {
                    // if (orderFormController.formKey.currentState!
                    //     .validate()) {
                    // Create a new order
                    final order = CustomerOrder(
                      // Use the renamed class
                      id: DateTime.now().toString(), // Unique ID
                      customerName: orderFormController.nameController.text,
                      customerAddress:
                          orderFormController.homeAddressController.text,
                      products: selectedProducts,
                    );

                    // Add the order to the OrderController
                    orderController.addOrder(order as Order);

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
  }
}
