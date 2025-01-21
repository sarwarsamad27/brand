import 'package:brand/barrelView/barrelView.dart';

class OrderFormScreen extends StatelessWidget {
  final List<Product> selectedProducts; // List of favorite products

  OrderFormScreen({super.key, required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    final orderFormController = Provider.of<Orderformcontroller>(context);
    final productDetailController =
        Provider.of<ProductDetailController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order Form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: orderFormController.formKey,
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
                                leading: Image.network(
                                  product.images[0],
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(product.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.shortDetails),
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
                      // onChanged: (value) => orderFormController.validateField(),
                      validator: orderFormController.validateName),

                  const SizedBox(height: 16),

                  // Email Field
                  CustomTextField(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      controller: orderFormController.emailController,
                      prefixIcon: const Icon(Icons.email),
                      hintText: 'Email',
                      focusNode: orderFormController.emailFocusNode,
                      // onChanged: (value) => orderFormController.validateField(),
                      validator: orderFormController.validateEmail),

                  const SizedBox(height: 16),

                  // Phone Number Field
                  CustomTextField(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      controller: orderFormController.phoneController,
                      prefixIcon: const Icon(Icons.phone),
                      hintText: '+92322-0270729',
                      focusNode: orderFormController.phoneFocusNode,
                      // onChanged: (value) => orderFormController.validateField(),
                      validator: orderFormController.validatePhone),

                  const SizedBox(height: 16),

                  // Country Dropdown
                  CustomDropdown(
                    items: orderFormController.countryList,
                    selectedItem: orderFormController.selectedCountry,
                    onChanged: (value) {
                      orderFormController.dropDownChangeValue(value);
                      // orderFormController.validateField();
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
                      // onChanged: (value) => orderFormController.validateField(),
                      validator: orderFormController.validateCity),

                  const SizedBox(height: 16),

                  // Postal Code Field
                  CustomTextField(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      controller: orderFormController.postalCodeController,
                      prefixIcon: const Icon(Icons.local_post_office),
                      hintText: 'Postal Code',
                      // onChanged: (value) => orderFormController.validateField(),
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
                      // onChanged: (value) => orderFormController.validateField(),
                      validator: orderFormController.validateHomeAddress),

                  const SizedBox(height: 24),

                  // Submit Button
                  CustomButton(
                    onTap: () {
                      if (orderFormController.formKey.currentState!
                          .validate()) {
                        orderFormController.submitForm(context);
                        productDetailController.clearCart();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Place Order"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
