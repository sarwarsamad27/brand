class SampleProductModel {
  final String id;
  final String name;
  final String imageUrl;
  final List<SampleProductModel> subProducts;

  SampleProductModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.subProducts = const [],
  });
}
