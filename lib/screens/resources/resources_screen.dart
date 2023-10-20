import 'package:ddofinance/models/resources/resources_model.dart';
import 'package:ddofinance/screens/resources/resources_table_layout.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:ddofinance/providers/resources/resources_provider.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:ddofinance/widgets/search_box.dart';
import 'package:provider/provider.dart';

/// Widget representing a page displaying a list of resources.
class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({Key? key}) : super(key: key);

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  Future<List<ResourcesModel>> resourcesData = Future.value([]);
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchController.addListener(_searchBoxFilteredData);
    WidgetsBinding.instance.addPostFrameCallback((_) => afterViewBuild());
  }
  ///To send the search term to the provider to filter the data.
  void _searchBoxFilteredData() {
    ResourceProvider provider =
    Provider.of<ResourceProvider>(context, listen: false);
    String searchTerm = _searchController.text.toLowerCase();
    provider.searchBoxFilteredData(searchTerm);
  }

  void afterViewBuild() {
    var resourceProvider =
        Provider.of<ResourceProvider>(context, listen: false);
    resourceProvider.loadResourcesData();
    resourcesData = resourceProvider.dataFromLocalStorageFuture;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mQSize = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(Insets.s30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Labels.resourcesHeading,
                    style: textTheme.titleLarge
              ?.copyWith(fontSize: MediaQuery.of(context).size.width / 57),
                    ),
                  SizedBox(
                      width: mQSize / 4,
                      child: SearchBox(
                        searchController: _searchController, searchBoxLabel: Labels.resourceSearchMessage,
                      )),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 51),
              LayoutBuilder(builder: (context, constraints) {
                return ResourcesTableLayout(
                    resourcesData: resourcesData, constraints: constraints);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
