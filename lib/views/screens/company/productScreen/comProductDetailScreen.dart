import 'package:flutter/material.dart';
import 'package:brand/generate/companySideModels/comProductModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ComProductDetailScreen extends StatefulWidget {
  final Product product;
  const ComProductDetailScreen({super.key, required this.product});

  @override
  State<ComProductDetailScreen> createState() => _ComProductDetailScreenState();
}

class _ComProductDetailScreenState extends State<ComProductDetailScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openFullScreen(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain, // pura screen me adjust karega
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),

              // ✅ Close button upar right me
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName ?? "Product Detail"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ✅ Product Images Carousel with Click-to-Zoom
            if (product.images != null && product.images!.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: product.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        final imageUrl = product.images![index];
                        return GestureDetector(
                          onTap: () => _openFullScreen(imageUrl),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// ✅ Smooth Dots Indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: product.images!.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      activeDotColor: Colors.deepPurple,
                      dotColor: Colors.grey.shade400,
                    ),
                  ),
                ],
              )
            else
              const Icon(Icons.image_not_supported,
                  size: 120, color: Colors.grey),

            const SizedBox(height: 20),

            /// ✅ Product Name
            Text(
              product.productName ?? "No Name",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// ✅ Description
            Text(
              product.productDescription ?? "No description available",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),

            const SizedBox(height: 20),

            /// ✅ Price & Discount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price: Rs. ${product.price ?? 0}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
                Text("Discount: ${product.discount ?? 0}%",
                    style: const TextStyle(fontSize: 16, color: Colors.green)),
              ],
            ),

            const SizedBox(height: 10),

            /// ✅ Stock
            Text("Stock: ${product.stock ?? 0}",
                style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 10),

            /// ✅ Category
            Text("Category: ${product.category ?? "N/A"}",
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
