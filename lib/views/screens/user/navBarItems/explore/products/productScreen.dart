import 'package:brand/barrelView/barrelView.dart';

class Productscreen extends StatefulWidget {
  const Productscreen({super.key, required CompanyProductUserSide product});

  @override
  _ProductscreenState createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 0; // To track the selected product index

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Convert CompanyProducts to CompanyProductUserSide
  CompanyProductUserSide _convertToUserSide(CompanyProducts product) {
    print('Converting product: ${product.name}, images: ${product.images}');
    return CompanyProductUserSide(
      name: product.name,
      imageUrl: product.images.isNotEmpty ? product.images.first : '',
      images: product.images,
      colors: product.colors,
      price: product.price.toString(),
      description: product.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sampleProductController =
        Provider.of<SampleProductController>(context);
    final productController = Provider.of<ProductController>(context);
    final sampleProducts = sampleProductController.products;
    final products = productController.products;

    print('Sample Products: ${sampleProducts.length}');
    print('Products: ${products.length}');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: FadeTransition(
                opacity: _fadeAnimation,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    sampleProducts.isNotEmpty
                        ? (Uri.tryParse(sampleProducts[_selectedIndex].imageUrl)
                                    ?.isAbsolute ==
                                true
                            ? Image.network(
                                sampleProducts[_selectedIndex].imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.broken_image,
                                        size: 50, color: Colors.grey),
                              )
                            : Image.file(
                                File(sampleProducts[_selectedIndex].imageUrl),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.broken_image,
                                        size: 50, color: Colors.grey),
                              ))
                        : Icon(Icons.image_not_supported,
                            size: 50, color: Colors.grey),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.5)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: CategoryHeaderDelegate(
              child: Container(
                color: Colors.grey[200],
                height: 50,
                child: sampleProducts.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sampleProducts.length,
                        itemBuilder: (context, index) {
                          final product = sampleProducts[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ChoiceChip(
                              label: Text(product.name),
                              selected: _selectedIndex == index,
                              selectedColor: Colors.blueGrey.shade300,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedIndex = index;
                                    _animationController.reset();
                                    _animationController.forward();
                                  });
                                }
                              },
                              backgroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          );
                        },
                      )
                    : Center(child: Text("No products available")),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = _convertToUserSide(products[index]);
                  print(
                      'Grid Product Image: ${product.images.isNotEmpty ? product.images.first : "No image"}');
                  return AnimatedGridItem(
                    product: product,
                    index: index,
                  );
                },
                childCount: products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Rest of the code (AnimatedGridItem, CategoryHeaderDelegate, CompanyProductUserSide) remains unchanged

// Animated Grid Item Widget
class AnimatedGridItem extends StatefulWidget {
  final CompanyProductUserSide product;
  final int index;

  const AnimatedGridItem({required this.product, required this.index});

  @override
  _AnimatedGridItemState createState() => _AnimatedGridItemState();
}

class _AnimatedGridItemState extends State<AnimatedGridItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) =>
          //         ProductDetailScreen(product: product),
          //   ),
          // );
        },
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: widget.product.images.isNotEmpty &&
                          widget.product.images.first.isNotEmpty
                      ? Image.network(
                          widget.product.images.first,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                            child: Icon(Icons.broken_image,
                                size: 50, color: Colors.grey),
                          ),
                        )
                      : const Center(
                          child: Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey),
                        ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Color: ${widget.product.colors.isNotEmpty && widget.index < widget.product.colors.length ? widget.product.colors[widget.index] : 'N/A'}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  "Price: ${widget.product.price}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  widget.product.description,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  CategoryHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class CompanyProductUserSide {
  final String name;
  final String imageUrl;
  final List<String> images;
  final List<String> colors;
  final String price;
  final String description;

  CompanyProductUserSide({
    required this.name,
    required this.imageUrl,
    required this.images,
    required this.colors,
    required this.price,
    required this.description,
  });
}
