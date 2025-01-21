import 'package:brand/barrelView/barrelView.dart';

class CustomSearchbar extends StatelessWidget {
  final Widget suffixicon;
  final Widget prefixicon;
  final double borderradius;
  final String? hintText;
  final Color? fillcolor;
  final Color? focuscolor;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextEditingController? controller; // Optional controller

  const CustomSearchbar({
    super.key,
    required this.suffixicon,
    required this.prefixicon,
    required this.borderradius,
    required this.hintText,
    this.fillcolor,
    this.focuscolor,
    this.validator,
    this.onChanged,
    this.controller, // Optional controller field
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderradius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller, // Assign the optional controller here
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            prefixIcon: prefixicon,
            suffixIcon: suffixicon,
            hintText: hintText,
            border: InputBorder.none,
          ),
          validator: validator,
        ),
      ),
    );
  }
}
