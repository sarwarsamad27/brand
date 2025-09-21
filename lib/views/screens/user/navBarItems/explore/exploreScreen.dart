import 'package:brand/barrelView/barrelView.dart';
import 'package:brand/view_model/Controller/userSideController.dart/exploreScreenController.dart';
import 'package:brand/views/screens/company/profileScreen/comProfileScreen.dart';
import 'package:brand/views/widget/animatedContainer.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreController = Provider.of<ExploreScreenController>(context);

    // 👉 screen load hote hi ek bar data fetch kare
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (exploreController.companies.isEmpty && !exploreController.isLoading) {
        exploreController.loadExplore();
      }
    });

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: exploreController.searchController,
                onChanged: (query) {
                  exploreController.searchProfiles(query);
                },
                decoration: InputDecoration(
                  hintText: 'Search product or brand',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      exploreController.clearSearch();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            // 📦 Body
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await exploreController.loadExplore();
                },
                child: Builder(
                  builder: (_) {
                    if (exploreController.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (exploreController.errorMessage.isNotEmpty) {
                      return Center(
                          child: Text(exploreController.errorMessage));
                    }

                    if (exploreController.filteredProfiles.isEmpty) {
                      return const Center(child: Text("No profiles found"));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 24.0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: exploreController.filteredProfiles.length,
                      itemBuilder: (context, index) {
                        final profile =
                            exploreController.filteredProfiles[index];

                        return AnimatedCompanyCard(
                          index: index,
                          imageUrl: profile.image ?? "",
                          title: profile.name ?? "No Name",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductEntryScreen(
                                  userId: profile.sId ?? '',
                                ),
                              ),
                            );
                          },
                          onAvatarTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompanyProfileScreen(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
