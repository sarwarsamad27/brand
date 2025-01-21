import 'package:brand/barrelView/barrelView.dart';

class OrderFormSelectedProd extends StatelessWidget {
  final List<Product> selectedProducts;

  const OrderFormSelectedProd({super.key, required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Orderformcontroller(),
      child: Consumer<Orderformcontroller>(
        builder: (context, formController, child) {
          final productDetailController =
              Provider.of<ProductDetailController>(context);

          final displayedProducts =
              productDetailController.selectedProduct != null
                  ? [productDetailController.selectedProduct!]
                  : selectedProducts;

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Order Form"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formController.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (displayedProducts.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Selected Product:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Card(
                                elevation: 2,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: displayedProducts.length,
                                  itemBuilder: (context, index) {
                                    final product = displayedProducts[index];
                                    return ListTile(
                                      leading: Image.network(
                                        product.images[0],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.error,
                                                    color: Colors.red),
                                      ),
                                      title: Text(product.name),
                                      subtitle: Text(product.shortDetails),
                                      trailing:
                                          Text('Quantity: ${product.quantity}'),
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
                            // onChanged: (value) =>
                            //     formController.validateField(),
                            // focusNode: formController.nameFocusNode,
                            validator: formController.validateName),

                        const SizedBox(height: 16),

                        // Email Field
                        CustomTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            controller: formController.emailController,
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'Email',
                            // onChanged: (value) =>
                            //     formController.validateField(),
                            // focusNode: formController.emailFocusNode,
                            validator: formController.validateEmail),

                        const SizedBox(height: 16),

                        // Phone Number Field
                        CustomTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            controller: formController.phoneController,
                            prefixIcon: const Icon(Icons.phone),
                            // focusNode: formController.phoneFocusNode,
                            // onChanged: (value) =>
                            //     formController.validateField(),
                            hintText: '+92322-0270729',
                            validator: formController.validatePhone),

                        const SizedBox(height: 16),

                        // Country Dropdown
                        // CustomDropdown(
                        //   items: formController.countryList,
                        //   selectedItem: formController.selectedCountry,
                        //   onChanged: formController.dropDownChangeValue,
                        //   isExpanded: true,
                        //   itemLabelBuilder: (String value) => value,
                        // ),

                        const SizedBox(height: 16),

                        // City Field
                        CustomTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            controller: formController.cityController,
                            prefixIcon: const Icon(Icons.location_city),
                            hintText: 'City',
                            // onChanged: (value) =>
                            //     formController.validateField(),
                            // focusNode: formController.cityFocusNode,
                            validator: formController.validateCity),

                        const SizedBox(height: 16),

                        // Postal Code Field
                        CustomTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            controller: formController.postalCodeController,
                            prefixIcon: const Icon(Icons.local_post_office),
                            hintText: 'Postal Code',
                            // onChanged: (value) =>
                            //     formController.validateField(),
                            // focusNode: formController.postalCodeFocusNode,
                            validator: formController.validatePostalCode),

                        const SizedBox(height: 16),

                        // Home Address Field
                        CustomTextField(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            controller: formController.homeAddressController,
                            prefixIcon: const Icon(Icons.home),
                            hintText: 'Home Address',
                            // onChanged: (value) => formController.validateField(),
                            // focusNode: formController.homeAddressFocusNode,
                            validator: formController.validateHomeAddress),

                        const SizedBox(height: 24),

                        // Submit Button
                        CustomButton(
                          onTap: () {
                            if (formController.formKey.currentState!
                                .validate()) {
                              // Save the address after form validation
                              formController.saveCurrentAddress();

                              // Show success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Order submitted successfully!')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please fix the errors in the form.')),
                              );
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
        },
      ),
    );
  }
}
