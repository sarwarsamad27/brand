import 'package:brand/view_model/Controller/userSideController.dart/exploreScreenController.dart';
import 'package:brand/view_model/Controller/companySideController/comproductDetailController.dart';
import 'package:brand/views/widget/animatedContainer.dart';
import 'package:brand/barrelView/barrelView.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ComProductDetailController>(context);

    return Consumer<ExploreScreenController>(
      builder: (context, exploreController, child) {
        final height = MediaQuery.of(context).size.height;
        // final width = MediaQuery.of(context).size.width;

        return Scaffold(
          backgroundColor: Colors.blueGrey.shade50,
          body: Column(
            children: [
              SizedBox(height: height * 0.05),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomSearchbar(
                  controller: _searchController,
                  onChanged: (query) {
                    exploreController.searchProducts(query);
                  },
                  borderradius: 10,
                  hintText: 'Search product or brand',
                  prefixicon: const Icon(Icons.search),
                  suffixicon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      exploreController.searchProducts('');
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 24.0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: exploreController.companies.length,
                      itemBuilder: (context, index) {
                        final company = exploreController.companies[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Productscreen(
                                          product: CompanyProductUserSide(
                                              name: 'name',
                                              imageUrl:
                                                  'https://picsum.photos/200/300?random=1',
                                              images: [],
                                              colors: [],
                                              price: '1345',
                                              description: 'description'),
                                        )));
                          },
                          child: AnimatedCompanyCard(
                            index: index,
                            productController: productController,
                            company: company,
                            product: null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
