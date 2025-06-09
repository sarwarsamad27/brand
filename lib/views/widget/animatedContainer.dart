import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/generate/userSideModel/exploreModel.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';
import 'package:brand/views/screens/company/profileScreen/comProfileScreen.dart';

class AnimatedCompanyCard extends StatefulWidget {
  final CompanyProductUserSide? product;
  final ExploreModel company;
  final int index;
  final ComProductDetailController productController;

  const AnimatedCompanyCard({
    this.product,
    required this.company,
    required this.index,
    required this.productController,
  });

  @override
  _AnimatedCompanyCardState createState() => _AnimatedCompanyCardState();
}

class _AnimatedCompanyCardState extends State<AnimatedCompanyCard>
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
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Productscreen(product: null,

              //     ),
              //   ),
              // );
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.company.imageUrl,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompanyProfileScreen()));
                },
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(widget.company.imageUrl),
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: Text(
                  widget.company.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
