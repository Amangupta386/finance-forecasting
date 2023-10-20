import 'package:ddofinance/providers/projects/add_new_projects_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/projects/projects_table_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:ddofinance/widgets/search_box.dart';

import '../../models/projects/project.dart';

/// Represents the screen displaying a list of projects.
class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);
  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  Future<List<ProjectModel>>? projectsData1;
  @override
  void initState() {
    super.initState();
    ProjectsProvider provider =

    Provider.of<ProjectsProvider>(context, listen: false);


        Provider.of<ProjectsProvider>(context, listen: false);

    /// Initialize the search controller and add a listener for filtering.
    provider.searchController = TextEditingController();
    provider.searchController.addListener(provider.searchBoxFilteredData);
    /// Load projects data after the view is built.
    WidgetsBinding.instance.addPostFrameCallback((_) =>afterViewBuild1());
  }


  void afterViewBuild1() {
    ProjectsProvider provider=Provider.of<ProjectsProvider>(context,listen: false);
    provider.loadProjectsData();
    projectsData1 = provider.dataFromApiCallFuture;
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
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Insets.s30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            Labels.projects,
                            style: textTheme.titleLarge
                                ?.copyWith(fontSize: deviceWidth / 57),
                          ),
                          SizedBox(
                            width: deviceWidth / 80,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // onclick();
                              Provider.of<AddProjectProvider>(context,listen: false).isClearTextFormFields(false);
                              context.goNamed('addProjectScreen');
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(EdgeInsets.only(
                                  top: deviceHeight / 35,
                                  bottom: deviceHeight / 35,
                                  left: deviceWidth / 55,
                                  right: deviceWidth / 55)),
                            ),
                            child: Text(
                              Labels.addNew,
                              style: textTheme.bodyMedium!
                                  .copyWith(color: colorTheme.secondary),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          width: deviceWidth / 4,
                          child: SearchBox(
                            searchController: Provider.of<ProjectsProvider>(context)
                                .searchController,
                            searchBoxLabel: Labels.searchBoxHintText,
                          )),
                    ],
                  ),
                  SizedBox(height: deviceHeight / 51),
                  LayoutBuilder(builder: (context, constraints) {
                    return ProjectsTableLayout(
                      projectsData: projectsData1,
                      constraints: constraints,
                    );
                  }),
                ],
              ),

            )));

  }
}
