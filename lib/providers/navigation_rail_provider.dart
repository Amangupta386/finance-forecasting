import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationRailProvider extends ChangeNotifier{
  int selectedIndex = 0;
  bool toggling = true;

  // AuthProvider authProvider = Provider.of<AuthProvider>(rootNavigatorKey.currentState!.context,listen: false);
  /// Toggles the selected state for an item.
  Future<void> toggleSelected(int index)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      if (selectedIndex == index ) {
        selectedIndex = 0; // Toggle off the selection if the same item is tapped again
      } else {
        selectedIndex = index;
      }
    notifyListeners();
    await prefs.setInt('selectedIndex', selectedIndex);
  }

  Future<void> loadSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    notifyListeners();
  }

  // Future<void> resetSelectedPreference() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('selectedIndex');
  // }
  //
  // Future<void> resetLoginToken()async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');
  // }


  /// Toggles the visibility of the left-side navigation rail.
  void onToggle() {
    toggling = !toggling;
    notifyListeners();
  }
}