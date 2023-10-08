import 'package:ddofinance/utils/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';

/// A custom Flutter widget for displaying a search input box with clear functionality.
///
/// This widget is designed to create a search input field with a hint text and a clear button.
/// It takes a [searchController] as an argument to manage the text input.
class SearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final String searchBoxLabel;
  const SearchBox(
      {Key? key, required this.searchController, required this.searchBoxLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    return TextField(
      onEditingComplete: () {
        CommonMethods.onEnterEvent(searchController);
      },
      mouseCursor: SystemMouseCursors.click,
      controller: searchController,
      style: textTheme.bodySmall,
      decoration: InputDecoration(
        hintText: searchBoxLabel,
        hintStyle: textTheme.bodySmall?.copyWith(
          color: colorTheme.onPrimary,
        ),
        suffixIcon: (searchController.text.isEmpty)
            ? // Search icon when the input field is empty.
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: () {
                    CommonMethods.onEnterEvent(searchController);
                  },
                  child: Icon(MaterialIcons.search)),
            )
            : IconButton(
                onPressed: () {
                  searchController
                      .clear(); //   Clear the text when the clear button is pressed.
                },
                icon: const Icon(MaterialIcons
                    .close)), // Close icon when there is text in the input field.
      ),
    );
  }
}
