import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/userSideModel/selectedProductModel.dart';

class SelectedProductScreen extends StatelessWidget {
  const SelectedProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductDetailController>(context);
    final product = productProvider.selectedProduct;

    return Product(
        images: product!.images,
        name: product.name,
        shortDetails: product.shortDetails,
        color: product.color);
  }
}
