import 'package:brand/barrelView/barrelView.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String hint;
  final bool isExpanded;
  final String Function(T) itemLabelBuilder;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.isExpanded,
    required this.itemLabelBuilder,
    this.hint = "Select an option",
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: selectedItem,
      hint: Text(hint),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColor.textSecondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppColor.textSecondaryColor),
        ),
        focusColor: Colors.grey,
      ),
      icon: Transform.rotate(
          angle: -3.142 / 2, child: const Icon(Icons.arrow_drop_down)
          // (Assets.arrowBack,color: AppColor.primaryColor),
          ),
      iconSize: 24,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      onChanged: onChanged,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: Text(
              itemLabelBuilder(item),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
