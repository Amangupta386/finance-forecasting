import 'package:ddofinance/models/projects/project.dart';
import 'package:ddofinance/utils/common_methods.dart';
import 'package:ddofinance/widgets/loaders/circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/projects/edit_project_provider.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:ddofinance/screens/projects/editProjectScreen/form_dropdown_fields.dart';
import 'package:ddofinance/screens/projects/editProjectScreen/form_input_fields.dart';
import 'package:ddofinance/widgets/go_back.dart';

/// A screen for editing project details.
class EditProjectScreen extends StatefulWidget {
  const EditProjectScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<EditProjectScreen> createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode focusNode;

  @override
  void initState() {
    ///Initializing focus node.
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    ///Disposing focus node.
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EditProjectProvider provider = Provider.of<EditProjectProvider>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final ColorScheme colorTheme = theme.colorScheme;

    ///Variable of radio button method.
    List<Widget> makeRadioListTile =
        Provider.of<EditProjectProvider>(context).makeRadioListTile(context);
    return Scaffold(
      appBar: const CustomAppBar(),

      ///We're getting record id from local storage and rendering that id particular record data in Edit ProjectScreen.
      body: FutureBuilder<ProjectsModel>(
          future: provider.findProjectById(),
          builder: (context, AsyncSnapshot<ProjectsModel> snapshot) {
            if (snapshot.hasData) {
              var selectedProject = snapshot.data!;

              ///Initializing all input fields text controller with initial value.

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: Insets.s28, top: Insets.s18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const GoBack(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        Labels.editProject,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Focus(
                          onKey: CommonMethods.changeFormFieldFocus,
                          focusNode: focusNode,
                          child: Form(
                              key: _formKey,
                              child: Column(children: [
                                ///Widget for displaying Text with Dropdown Field.
                                FormDropdownFields(
                                  label: Labels.financialYear,
                                  selectedValue:
                                      provider.financialYearInitialValue,
                                  items: provider.financialYearDropDownData,
                                ),

                                ///Widget for displaying Text with Input Field.
                                FormInputFields(
                                  label: Labels.clientName,
                                  initialValue: selectedProject.clientName,
                                  enableTextField: true,
                                  index: selectedProject.id,
                                ),
                                FormInputFields(
                                  index: selectedProject.id,
                                  label: Labels.projectName,
                                  initialValue: selectedProject.projectName,
                                  enableTextField: true,
                                ),
                                FormDropdownFields(
                                  label: Labels.country,
                                  selectedValue: provider.countryInitialValue,
                                  items: provider.countryDropDownData,
                                ),
                                FormDropdownFields(
                                  label: Labels.currency,
                                  selectedValue: provider.currencyInitialValue,
                                  items: provider.currencyDropDownData,
                                ),
                                FormDropdownFields(
                                  label: Labels.paymentTeam,
                                  selectedValue:
                                      provider.paymentTeamInitialValue,
                                  items: provider.paymentTeamDropDownData,
                                ),
                                FormDropdownFields(
                                  label: Labels.businessUnit,
                                  selectedValue: provider.buInitialValue,
                                  items: provider.businessUnitDropDownData,
                                ),
                                FormInputFields(
                                  index: selectedProject.id,
                                  label: Labels.projectForecast,
                                  initialValue: selectedProject.projectForecast
                                      .toString(),
                                  enableTextField: false,
                                ),
                                FormInputFields(
                                  index: selectedProject.id,
                                  label: Labels.projectActualCost,
                                  initialValue:
                                      selectedProject.actualCost.toString(),
                                  enableTextField: false,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Insets.s10),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: deviceWidth / 7.7,
                                          child: Text(
                                            Labels.status,
                                            style: theme.textTheme.bodyMedium!
                                                .copyWith(
                                                    color:
                                                        colorTheme.onPrimary),
                                          )),
                                      SizedBox(
                                        width: deviceWidth / 42.5,
                                      ),

                                      ///Radio buttons
                                      ...makeRadioListTile
                                    ],
                                  ),
                                ),
                              ]))),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: deviceWidth / 6.1),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                provider.addSelectedValues.clear();
                                _formKey.currentState!.save();
                                provider.saveData(context);
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.only(
                                        top: Insets.s20,
                                        bottom: Insets.s20,
                                        left: Insets.s20,
                                        right: Insets.s20)),
                              ),
                              child: const Text(
                                Labels.save,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.only(
                                            top: Insets.s20,
                                            bottom: Insets.s20,
                                            left: Insets.s20,
                                            right: Insets.s20)),
                                    foregroundColor: MaterialStateProperty.all(
                                        colorTheme.onBackground),
                                    backgroundColor: MaterialStateProperty.all(
                                        colorTheme.onSurfaceVariant),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ))),
                                onPressed: () {
                                  setState(() {
                                    context.pop();
                                  });
                                },
                                child: const Text(Labels.cancel))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const CircularLoader();
            }
          }),
    );
  }
}
