import 'package:brand/barrelView/barrelView.dart';

class ContentWidget extends StatelessWidget {
  final String serialNumber;
  final String heading;
  final String content;
  const ContentWidget(
      {super.key,
      required this.serialNumber,
      required this.heading,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CustomText(
              text: serialNumber,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            CustomText(
              text: heading,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        CustomText(text: content),
      ],
    );
  }
}
