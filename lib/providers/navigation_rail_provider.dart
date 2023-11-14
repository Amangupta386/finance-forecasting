import 'package:ddofinance/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationRailProvider extends ChangeNotifier {
  int selectedIndex = 0;
  bool toggling = true;
  String location = Uri.base.path;

  /// Toggles the selected state for an item.
  Future<void> toggleSelected(int index, String? url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedIndex = index;
    if (url != null) {
      GoRouter.of(rootNavigatorKey.currentState!.context).go(url);
    }
    await prefs.setInt('selectedIndex', selectedIndex);
    notifyListeners();
  }

  Future<int> loadSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    notifyListeners();
    return selectedIndex;
  }

  /// Toggles the visibility of the left-side navigation rail.
  void onToggle() {
    toggling = !toggling;
    notifyListeners();
  }
}
