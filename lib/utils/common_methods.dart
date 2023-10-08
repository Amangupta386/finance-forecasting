import 'package:ddofinance/routing/app_router.dart';
import 'package:ddofinance/widgets/loaders/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonMethods {
  /// Shows a  CircularProgressIndicator if server side call is in progress.
  static setLoaderStatus([enable = false]) {
    if (enable) {
      return const CircularLoader();
    }
    Navigator.of(rootNavigatorKey.currentState!.context).pop();
  }

  static onEnterEvent(TextEditingController controller) {
    if (controller.text.length > 2) {
      //handle on enter event in the search box and filter out you data.
      print('filteredData');
    }
  }

  static KeyEventResult changeFormFieldFocus(
      FocusNode focusNode, RawKeyEvent event) {
    var events = event.runtimeType == RawKeyUpEvent;

    if (events && event.logicalKey == LogicalKeyboardKey.arrowRight) {
      focusNode.focusInDirection(TraversalDirection.right);
      return KeyEventResult.handled;
    } else if (events && event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      focusNode.focusInDirection(TraversalDirection.left);
      return KeyEventResult.handled;
    } else if (events && event.logicalKey == LogicalKeyboardKey.arrowUp) {
      focusNode.focusInDirection(TraversalDirection.up);
      return KeyEventResult.handled;
    } else if (events && event.logicalKey == LogicalKeyboardKey.arrowDown) {
      focusNode.focusInDirection(TraversalDirection.down);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
