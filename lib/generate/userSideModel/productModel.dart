import 'package:brand/barrelView/barrelView.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl; // Product Image URL
  final String name; // Product Name
  final String shortDetails; // Product Short Details
  String? longDetails; // Product long Details
  final String color; // Product Color Information
  int quantity;

  ProductCard({
    super.key,
    this.longDetails,
    required this.imageUrl,
    required this.name,
    required this.shortDetails,
    required this.color,
    this.quantity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                      child: Icon(Icons.error, color: Colors.red));
                },
              ),
            ),
          ),
          // Product Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Product Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              shortDetails,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Product Color
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              color,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          //long detail

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              quantity.toString(),
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
