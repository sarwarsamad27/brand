// class CompanyProduct {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final String imageUrl;
//   final int stock;

//   CompanyProduct({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.imageUrl,
//     required this.stock,
//   });
// }

class CompanyProduct {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final int stock;
  final double? discountPrice;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;

  CompanyProduct({
    required this.id,
    required this.name,
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
  CompanyProduct copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    double? price,
    int? stock,
    double? discountPrice,
    List<String>? images,
    List<String>? sizes,
    List<String>? colors,
  }) {
    return CompanyProduct(
      id: id ?? this.id,
      name: name ?? this.name,
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
