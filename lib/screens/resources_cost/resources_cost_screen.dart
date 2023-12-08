import 'package:ddofinance/providers/navigation_rail_provider.dart';
import 'package:ddofinance/screens/resources_cost/resources_cost_table_layout.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:ddofinance/widgets/search_box.dart';
import 'package:ddofinance/widgets/upload_file_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';
import 'package:ddofinance/providers/resources_cost/resources_cost_data_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';

/// Widget representing a page displaying a list of resources cost.
class ResourcesCostScreen extends StatefulWidget {
  const ResourcesCostScreen({super.key});

  @override
  State<ResourcesCostScreen> createState() => _ResourcesCostScreenState();
}

class _ResourcesCostScreenState extends State<ResourcesCostScreen> {
  Future<List<ResourcesCostModel>>? resourcesCostData = Future.value([]);

  final TextEditingController _searchController = TextEditingController();

  ///To add a listener to the search controller.
  @override
  void initState() {
    super.initState();
    NavigationRailProvider navigationRailProvider =
        Provider.of<NavigationRailProvider>(context, listen: false);
    navigationRailProvider.toggleSelected(3, null);
    _searchController.addListener(_searchBoxFilteredData);
    WidgetsBinding.instance.addPostFrameCallback((_) => afterViewBuild());
  }

  ///To send the search term to the provider to filter the data.
  void _searchBoxFilteredData() {
    ResourcesCostDataProvider provider =
        Provider.of<ResourcesCostDataProvider>(context, listen: false);
    String searchTerm = _searchController.text.toLowerCase();
    provider.filterData(searchTerm);
  }

  void afterViewBuild() {
    ResourcesCostDataProvider resourceCostProvider =
        Provider.of<ResourcesCostDataProvider>(context, listen: false);
    resourceCostProvider.loadResourceCostData();
    resourcesCostData = resourceCostProvider.dataFromLocalStorageFuture;
  }

  /// To dispose the controller.
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResourcesCostDataProvider provider =
        Provider.of<ResourcesCostDataProvider>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    double deviceHeight = mQ.size.height;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        provider.tapHandler();
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Padding(
          padding: EdgeInsets.all(Insets.s30),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // SizedBox(height: deviceWidth / 52),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          Labels.resourcesCost,
                          style: textTheme.titleLarge
                              ?.copyWith(fontSize: deviceWidth / 57),
                        ),
                        SizedBox(
                          width: deviceWidth / 80,
                        ),
                        const UploadFileButton(),
                        SizedBox(
                          width: deviceWidth / 80,
                        ),
                        TextButton(
                          onPressed: () {
                            provider.onSave();
                          },
                          style: theme.textButtonTheme.style,
                          child: const Text(Labels.save),
                        )
                      ],
                    ),
                    Container(
                        width: deviceWidth / 4,
                        height: deviceHeight / 16,
                        decoration: BoxDecoration(
                          color: colorTheme.secondary,
                          borderRadius: BorderRadius.circular(Insets.s4),
                        ),
                        child: SearchBox(
                            searchController: _searchController,
                            searchBoxLabel: Labels.searchEmployee))
                  ],
                ),
                SizedBox(height: deviceHeight / 51),
                LayoutBuilder(builder: (context, constraints) {
                  return ResourcesCostTableLayout(
                    resourcesCostData: resourcesCostData,
                    constraints: constraints,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
