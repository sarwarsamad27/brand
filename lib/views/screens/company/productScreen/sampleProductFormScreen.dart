import 'package:brand/barrelView/barrelView.dart';

class SampleProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<SampleProductController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: productController.pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
                child: productController.pickedImage != null
                    ? Stack(
                        children: [
                          Image.file(
                            productController.pickedImage!,
                            fit: BoxFit.contain,
                            width: double.infinity,
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: productController.removeImage,
                              child: const Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                        ],
                      )
                    : const Icon(Icons.add_a_photo, size: 50),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: productController.nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                productController.saveProduct(context);
              },
              child: const Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
