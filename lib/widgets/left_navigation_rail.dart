import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/navigation_rail_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/device_screens/screen_size.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/models/navigation_rail_model.dart';
import 'package:ddofinance/utils/constants/images.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:ddofinance/utils/device_screens/device_info.dart';
import 'package:ddofinance/widgets/image_asset.dart';
import 'package:ddofinance/widgets/positioned_all.dart';
import 'package:provider/provider.dart';

/// A custom Flutter widget that combines a left-side navigation rail with a content area.
///
/// Users can toggle the visibility of the navigation rail using a button.
class LeftNavigationRail extends StatelessWidget {
  final Widget child;

  /// - [child]: The child widget representing the content area.
  const LeftNavigationRail({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size;
    final deviceWidth = mQ.width;
    final height = mQ.height;
    final theme = Theme.of(context);
    final themeColor = theme.colorScheme;
    NavigationRailProvider provider =
        Provider.of<NavigationRailProvider>(context);

    // This item is just taking navigationRail item data and store in a list of item so that it give data to NavigationRailItem class.
    const List<NavigationRailModel> item = MasterData.navigationRailItemData;
    // Create a layout that combines the left navigation rail and main content.
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Row(
          children: [
            SizedBox(
              width: (provider.toggling)
                  ? deviceWidth / 8
                  : deviceWidth /
                      12, //Through this it's increase or decreases the width of navigation rail.
              child: Drawer(
                backgroundColor: themeColor.primary,
                //On toggling the width of the navigation rail is going to decrease and it's label is also going to empty.
                child: (provider.toggling)
                    ? Padding(
                        padding: EdgeInsets.only(top: Insets.s14),
                        child: Column(
                          children: [
                            buildImageAsset(deviceWidth),
                            // Loop is going to execute 4 times and through this 4 NavigationRailItem is going to create with different items.
                            for (final ele in item)
                              NavigationRailItem(
                                ele.toggleImage,
                                ele.image,
                                ele.route,
                                txt: ele.label,
                                isSelected: provider.selectedIndex == ele.index,
                                onTap: () {
                                  provider.toggleSelected(ele.index, ele.route);
                                },
                              ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: Insets.s18),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildImageAsset(deviceWidth),
                            //This also going to create 4 items with empty text because of toggling.
                            for (final ele in item)
                              NavigationRailItem(
                                ele.toggleImage,
                                ele.image,
                                ele.route,
                                txt: '',
                                isSelected: provider.selectedIndex == ele.index,
                                onTap: () {
                                  provider.toggleSelected(ele.index, ele.route);
                                },
                              ),
                          ],
                        ),
                      ),
              ),
            ),
            Expanded(child: child),
          ],
        ),
        // This below code is used to toggle the icon rightIcon to leftIcon and also for the positioning the icon.
        PositionedAll(
          top: height / 17,
          left: (provider.toggling) ? deviceWidth / 8.5 : deviceWidth / 12.5,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              key: const ValueKey('railShifting'),
              onTap: provider.onToggle,
              child: CircleAvatar(
                  backgroundColor: themeColor.secondary,
                  radius: Sizes.s12,
                  child: (provider.toggling)
                      ? Icon(
                          MaterialIcons.keyboardArrowLeft,
                          color: themeColor.onSecondary,
                        )
                      : Icon(
                          MaterialIcons.keyboardArrowRight,
                          color: themeColor.onSecondary,
                        )),
            ),
          ),
        )
      ],
    );
  }

  static ImageAsset buildImageAsset(double deviceWidth) {
    return ImageAsset(
      imageName: Images.walkingtreeLogo,
      width: deviceWidth / 20,
    );
  }
}

/// A custom Flutter widget representing an item in a navigation rail or side navigation menu.
///
/// This widget consists of an icon, text, and a URL that is navigated to when the item is tapped.
class NavigationRailItem extends StatelessWidget {
  final String image1;
  final String? txt;
  final String image2;
  final String url;
  final bool isSelected;
  final VoidCallback onTap;

  /// Creates a new instance of the [NavigationRailItem] widget.
  ///
  /// - [image1]: The path to the first image icon (for selected state).
  /// - [txt]: The text label associated with the item.
  /// - [image2]: The path to the second image icon (for deselected state).
  /// - [url]: The URL to navigate to when the item is tapped.
  /// - [isSelected]: Indicates whether the item is selected or not.
  /// - [onTap]: The callback function to be executed when the item is tapped.
  const NavigationRailItem(
    this.image1,
    this.image2,
    this.url, {
    super.key,
    this.txt,
    required this.isSelected,
    required this.onTap,
  });

  // @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final isMediumScreen = DeviceScreen.isTablet(context);
    final isLargeScreen = DeviceScreen.isLargeScreen(context);
    DashboardProvider dashboardProvider =
        Provider.of<DashboardProvider>(context);
    // print(Uri.base.path);

    //Text rendering based on screen size.
    Widget getText(color) {
      return (isLargeScreen)
          ? Text(txt!,
              style: TextStyle(color: color, fontSize: deviceWidth / 100))
          : (isMediumScreen)
              ? const Text('')
              : const Text('');
    }

    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(
          left: deviceWidth / 90,
          top: Insets.s24,
        ),
        child: (isSelected)
            ?
            // Define a custom indicator based on the selected state.
            selectedIndicator(theme, deviceWidth, getText)
            : customIndicator(theme, deviceWidth, getText),
      ),
      onTap: () {
        onTap(); // Execute the onTap callback and change the index so that it goes on next indicator.
        try {
          dashboardProvider
              .dashboardAndProjectOtherExpenseModelData[
                  dashboardProvider.dropdownIndex]
              .isDropdownIndexOpen = false;
        }  catch (e) {
          if (kDebugMode) {
            print('This is error $e');
          }
        }
      },
    );
  }

  Widget? customIndicator(ThemeData theme, double deviceWidth,
      Widget Function(Color color) getText) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: Sizes.s30,
        decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(4))),
        padding: EdgeInsets.only(
          left: Insets.s10,
        ),
        child: Row(
          children: [
            ImageAsset(
              imageName: image2,
              width: ScreenSize.getImageSize(
                largeImageSize: deviceWidth / 90,
                mediumImageSize: deviceWidth / 60,
                smallImageSize: deviceWidth / 50,
              ),
            ),
            SizedBox(
              width: Sizes.s10,
            ),
            getText(theme.colorScheme.secondary),
          ],
        ),
      ),
    );
  }

  Widget? selectedIndicator(ThemeData theme, double deviceWidth,
      Widget Function(dynamic color) getText) {
    return IgnorePointer(
      child: Container(
        height: Sizes.s30,
        decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(4))),
        padding: EdgeInsets.only(
          left: Insets.s10,
        ),
        child: Row(
          children: [
            ImageAsset(
              imageName: image1,
              width: ScreenSize.getImageSize(
                largeImageSize: deviceWidth / 90,
                mediumImageSize: deviceWidth / 60,
                smallImageSize: deviceWidth / 50,
              ),
            ),
            SizedBox(
              width: Sizes.s10,
            ),
            getText(theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
