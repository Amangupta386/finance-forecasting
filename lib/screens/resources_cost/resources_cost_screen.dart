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
  const ResourcesCostScreen({Key? key}) : super(key: key);

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
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    double deviceHeight = mQ.size.height;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;

    return Scaffold(
      appBar:  CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(Insets.s30),
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
                  ],
                ),
                Container(
                  width: deviceWidth / 4,
                  height: deviceHeight / 16,
                  decoration: BoxDecoration(
                    color: colorTheme.secondary,
                    borderRadius: BorderRadius.circular(Insets.s4),
                  ),
                  child: SearchBox(searchController: _searchController, searchBoxLabel: Labels.searchEmployee,)
                )
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
    );
  }
}