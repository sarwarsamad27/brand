import 'package:brand/barrelView/barrelView.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget modernAppBar(BuildContext context,
    {required String name, required String detail}) {
  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: false,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFDF762E),
            Color(0xFFFFA858),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          detail,
          style: const TextStyle(fontSize: 14, color: AppColor.blackcolor),
        ),
      ],
    ),
  );
}
