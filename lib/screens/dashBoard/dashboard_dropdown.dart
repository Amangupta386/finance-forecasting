import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/widgets/custom_chart.dart';
import 'package:ddofinance/widgets/custom_form_fields.dart';
import 'package:ddofinance/widgets/custom_grid.dart';
import 'package:ddofinance/widgets/go_back.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DashboardDropDown extends StatelessWidget {
  const DashboardDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    var mQ = MediaQuery.of(context).size;
    var deviceHeight = mQ.height;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    DashboardProvider provider = Provider.of<DashboardProvider>(context);
    ProjectsProvider projectsProvider = Provider.of<ProjectsProvider>(context);

    return Material(
            child: Container(
              color: colorTheme.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (projectsProvider.toMove == false)
                    SizedBox(height: mQ.height / 100),
                  if (projectsProvider.toMove == true)
                    Padding(
                      padding: EdgeInsets.only(left: Insets.s30, top: Insets.s24),
                      child: const GoBack(),
                    ),
                  if (projectsProvider.toMove == false)
                    SizedBox(height: mQ.height / 100),
                  if (projectsProvider.toMove == true)
                    Padding(
                      padding: EdgeInsets.only(left: Insets.s30, top: Insets.s20),
                      child: RichText(
                        text: TextSpan(
                          text: Labels.projectLabel,
                          style: textTheme.titleLarge
                              ?.copyWith(fontSize: MediaQuery.of(context).size.width / 57),
                          children: <TextSpan>[
                            TextSpan(
                                text: projectsProvider
                                    .filteredSearchBoxData.isNotEmpty ? projectsProvider.filteredSearchBoxData[projectsProvider.projectIndex]
                                    .customerName : '',
                                style: textTheme.titleLarge?.copyWith(
                                    color: colorTheme.primary,
                                    fontSize: mQ.width / 57)),
                          ],
                        ),
                      ),
                    ),
                  if (projectsProvider.toMove == true)
                    SizedBox(height: mQ.height / 60),

                  /// DashBoard header
                  if (projectsProvider.toMove == true)
                    SizedBox(height: mQ.height / 51.66),
                  if (projectsProvider.toMove == false)
                    Padding(
                      padding:  EdgeInsets.only(left:Insets.s30,right: 30,bottom: 20, top: 20),
                      child: Text(
                        Labels.dashBoard,
                        style: textTheme.titleLarge
                            ?.copyWith(fontSize: mQ.width / 57),
                      ),
                    ),
                  if (projectsProvider.toMove == false)
                  // SizedBox(height: mQ.width / 60),
                    if (projectsProvider.toMove == false)
                      Container(
                        alignment: Alignment.center,
                        height: mQ.height / 4.93,
                        margin: const EdgeInsets.only(left: 30, right: 16),
                        padding: EdgeInsets.all(deviceHeight/64),
                        decoration: BoxDecoration(
                          color: colorTheme.outlineVariant,
                          borderRadius: BorderRadius.circular(Insets.s5),
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: (provider.dropDownData1.isEmpty && provider.dropDownData2.isEmpty && provider.dropDownData3.isEmpty && provider.dropDownData4.isEmpty)? const CircularProgressIndicator():
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomFormFields(
                                label: Labels.financialYear,
                                items: provider.dropDownData1,
                              ),
                              SizedBox(
                                width: mQ.width / 64,
                              ),
                              CustomFormFields(
                                  label: Labels.bu, items: provider.dropDownData2),
                              SizedBox(
                                width: mQ.width / 64,
                              ),
                              CustomFormFields(
                                  label: Labels.client, items: provider.dropDownData3),
                              SizedBox(
                                width: mQ.width / 64,
                              ),
                              CustomFormFields(
                                  label: Labels.project,
                                  items: provider.dropDownData4),
                              SizedBox(
                                width: mQ.width / 64,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Insets.s4),
                                ),
                                padding: EdgeInsets.only(top: mQ.width / 80),
                                height: mQ.height / 11.39,
                                width: mQ.width / 16,
                                child: TextButton(
                                  onPressed: () {},
                                  style: theme.textButtonTheme.style,
                                  child: Text(Labels.show,
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorTheme.secondary,
                                        fontSize: mQ.width / 100,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  if (projectsProvider.toMove == false)
                    SizedBox(height: mQ.width / 53),
                  Padding(
                    padding: EdgeInsets.only(left: Insets.s30, right: Insets.s16),
                    child: FittedBox(
                      child: Row(
                        children: [
                          const CustomGrid(),
                          SizedBox(
                            width: mQ.width / 80,
                          ),
                          const CustomChart(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight / 51,
                  )
                ],
              ),
            ),
          );
  }
}