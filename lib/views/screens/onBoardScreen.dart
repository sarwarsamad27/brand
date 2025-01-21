import 'package:brand/barrelView/barrelView.dart';

// ignore: must_be_immutable
class Onboardscreen extends StatelessWidget {
  Onboardscreen({super.key});
  List<BoardingModel> boarding = [
    BoardingModel(
        image:
            'https://th.bing.com/th/id/OIP.4PlT0k0QaFBQnAet2r2XsQHaHa?pid=ImgDet&rs=1',
        // 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwisepops.com%2Fblog%2F15-gorgeous-pop-up-design-examples-you-can-copy-today&psig=AOvVaw3tfL0Mbi2OF4TJc0nrZj19&ust=1734946697486000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCLifzqaKu4oDFQAAAAAdAAAAABAE',
        body: 'E-Commerse shopping application',
        title: 'SHOP-POP'),
    BoardingModel(
        image:
            'https://th.bing.com/th/id/OIP.4PlT0k0QaFBQnAet2r2XsQHaHa?pid=ImgDet&rs=1',
        body: 'the fastest delivery in the world',
        title: 'Fast Delivery'),
    BoardingModel(
        image:
            'https://th.bing.com/th/id/OIP.4PlT0k0QaFBQnAet2r2XsQHaHa?pid=ImgDet&rs=1',
        body: 'Deliver the best quality of everything',
        title: 'Trusted services'),
  ];

  @override
  Widget build(BuildContext context) {
    final onBoardController = Provider.of<Onboardcontroller>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () => onBoardController.submit(context),
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 20),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: onBoardController.boardingController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    onBoardController.isTrue();
                  } else {
                    onBoardController.isFalse();
                  }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onBoardController.boardingController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: AppColor.popUpColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (onBoardController.isLast) {
                      onBoardController.submit(context);
                    } else {
                      onBoardController.boardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: NetworkImage(model.image))),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: Colors.redAccent,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
        ],
      );
}
