import 'package:ddofinance/providers/resources_cost/resources_cost_data_provider.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

/// A custom Flutter widget for displaying a search input box with clear functionality.
///
/// This widget is designed to create a search input field with a hint text and a clear button.
/// It takes a [searchController] as an argument to manage the text input.
class SearchBox extends StatelessWidget {
  final TextEditingController searchController;
  final String searchBoxLabel;
  final VoidCallback? provider;
  const SearchBox(
      {Key? key,
      required this.searchController,
      required this.searchBoxLabel,
      this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ResourcesCostDataProvider provider =
        Provider.of<ResourcesCostDataProvider>(context);
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    return TextField(
      readOnly: provider.hasEmptyOrInvalidFields,
      onTap: () {
        if (provider.hasEmptyOrInvalidFields) {
          Fluttertoast.showToast(
              msg: Labels.warningMessage,
              webBgColor: 'Color.fromRGBO(0, 50, 144, 1)',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              fontSize: 16.0);
        }
        provider.tapHandler();
      },
      onEditingComplete: () {
        if (searchController.text.length > 2) {
          searchController;
        }
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
                      if (searchController.text.length > 2) {
                        searchController;
                      }
                    },
                    child: const Icon(MaterialIcons.search)),
              )
            : IconButton(
                onPressed: () {
                  provider.tapHandler();
                  searchController
                      .clear(); //   Clear the text when the clear button is pressed.
                },
                icon: const Icon(MaterialIcons
                    .close)), // Close icon when there is text in the input field.
      ),
    );
  }
}
