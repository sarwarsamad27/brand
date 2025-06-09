import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

class CustomFlashBar extends StatelessWidget {
  final String title; // Required title parameter

  const CustomFlashBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom FlashBar Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showCustomFlashbar(context);
          },
          child: const Text('Show Custom FlashBar'),
        ),
      ),
    );
  }

  // Function to show the custom FlashBar
  void _showCustomFlashbar(BuildContext context) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          controller: controller,

          position: FlashPosition.top, // Position the FlashBar at the top
          child: FlashBar(
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white, // Custom icon color
            ),
            title: Text(
              title, // Use the required title passed to the widget
              style: const TextStyle(
                color: Colors.white, // Custom title color
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'This is a custom FlashBar notification.',
              style: TextStyle(
                color: Colors.white, // Custom content text color
              ),
            ),
            controller: controller,
          ),
        );
      },
    );
  }
}
