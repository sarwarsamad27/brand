import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/repository/userSideController.dart/exploreController.dart';
import 'package:brand/views/widget/customFadeAnimation.dart';

class Explorescreen extends StatelessWidget {
  const Explorescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileScreenController =
        Provider.of<Profilescreencontroller>(context);
    final exploreController = Provider.of<ExploreScreenController>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            // Custom Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomSearchbar(
                suffixicon: const Icon(Icons.search, color: Colors.grey),
                prefixicon: const Icon(Icons.explore, color: Colors.blue),
                borderradius: 20,
                hintText: 'Search for a brand',
                onChanged: (query) {
                  exploreController.filterBrands(query);
                },
              ),
            ),
            SizedBox(height: height * 0.02),

            // Grid View Section
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: width * 0.04,
                  mainAxisSpacing: height * 0.02,
                  childAspectRatio: 0.75,
                ),
                itemCount: exploreController.filteredBrands.length,
                itemBuilder: (context, index) {
                  final brandName = exploreController.filteredBrands[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.productScreen);
                    },
                    child: FadeIn(
                      delay: Duration(milliseconds: 200 + (index * 100)),
                      child: Stack(
                        children: [
                          // Full Image with Rounded Corners
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: profileScreenController.selectedImage != null
                                ? Image.file(
                                    profileScreenController.selectedImage!,
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.blue.shade100,
                                    child: const Icon(
                                      Icons.business,
                                      size: 60,
                                      color: Colors.blue,
                                    ),
                                  ),
                          ),

                          // Brand Name Overlay at the Bottom
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(16),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.01,
                              ),
                              child: Text(
                                brandName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: height * 0.02,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
