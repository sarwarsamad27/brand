import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHelpers {
  static void removeFocus(BuildContext context, FocusNode currentFocus) {
    if (currentFocus.hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  static void focusShift(BuildContext context, FocusNode nextFocus) {
    if (!nextFocus.hasFocus) {
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }

  static bool detectBackspaceKey(KeyEvent event) {
    if (event.logicalKey == LogicalKeyboardKey.cancel) {
      return true;
    } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
      return true;
    } else if (event.logicalKey == LogicalKeyboardKey.clear) {
      return true;
    } else if (event.physicalKey == PhysicalKeyboardKey.backspace) {
      return true;
    } else {
      return false;
    }
  }

  static void backspaceKeyHandle(KeyEvent event, FocusNode currentFocus,
      TextEditingController previousController) {
    if (event.physicalKey == PhysicalKeyboardKey.backspace &&
        currentFocus.hasFocus) {
      previousController.clear();
    }
  }

  static void clearField(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      controller.clear();
    }
  }

  static void showFullBottomSheet(BuildContext context, Widget sheet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => sheet,
    );
  }
}
