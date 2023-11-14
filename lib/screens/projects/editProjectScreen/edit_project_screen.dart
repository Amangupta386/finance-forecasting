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
import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';

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
    //It is adding financial Year DD
    Provider.of<DashboardProvider>(context, listen: false)
        .addingDropDownValues();
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
      body: FutureBuilder<ProjectModel>(
          future: provider.findProjectById(),
          builder: (context, AsyncSnapshot<ProjectModel> snapshot) {
            if (snapshot.hasData) {
              var selectedProject = snapshot.data!;
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
                                  selectedProject.financialYearName,
                                  items: Provider.of<DashboardProvider>(context)
                                      .dropDownData1,
                                ),

                                ///Widget for displaying Text with Input Field.
                                FormInputFields(
                                  label: Labels.clientName,
                                  initialValue: selectedProject.customerName,
                                  enableTextField: false,
                                ),
                                FormInputFields(
                                  label: Labels.projectName,
                                  initialValue: selectedProject.projectName,
                                  enableTextField: false,
                                ),
                                FormInputFields(
                                  label: Labels.country,
                                  initialValue: 'India',
                                  enableTextField: false,
                                ),
                                FormInputFields(
                                  label: Labels.currency,
                                  initialValue: 'INR',
                                  enableTextField: false,
                                ),
                                FormInputFields(
                                  label: Labels.paymentTerm,
                                  initialValue: '3 months',
                                  enableTextField: false,
                                ),
                                FormInputFields(
                                  label: Labels.businessUnit,
                                  initialValue: 'Akshay Shrivastava',
                                  enableTextField: false,
                                ),

                                FormInputFields(
                                  label: Labels.projectForecast,
                                  initialValue:
                                  selectedProject.forecast.toString(),
                                  enableTextField: true,
                                ),
                                FormInputFields(
                                  label: Labels.projectActualCost,
                                  initialValue: selectedProject.actual,
                                  enableTextField: true,
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
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  provider.updateData(context,selectedProject);
                                }
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
                                child: const Text(Labels.cancel)),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20,)
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
