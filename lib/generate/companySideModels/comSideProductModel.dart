class CompanyProducts {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final int stock;
  int quantity;

  final double? discountPrice;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;

  CompanyProducts({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.category,
    required this.price,
    required this.stock,
    this.discountPrice,
    required this.images,
    required this.sizes,
    required this.colors,
  });

  // The copyWith method
  CompanyProducts copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    double? price,
    int? stock,
    int? quantity,
    double? discountPrice,
    List<String>? images,
    List<String>? sizes,
    List<String>? colors,
  }) {
    return CompanyProducts(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      discountPrice: discountPrice ?? this.discountPrice,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
    );
  }
}
