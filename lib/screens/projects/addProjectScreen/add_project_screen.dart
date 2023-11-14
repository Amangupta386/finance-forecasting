import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/providers/projects/edit_project_provider.dart';
import 'package:ddofinance/screens/projects/addProjectScreen/add_new_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/projects/add_new_projects_provider.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:ddofinance/widgets/go_back.dart';
import 'package:ddofinance/models/projects/add_new_project.dart';
import 'package:ddofinance/theme/styles.dart';
import 'package:ddofinance/utils/common_methods.dart';
import 'package:ddofinance/utils/constants/labels.dart';
import 'package:ddofinance/utils/constants/material_icons.dart';
import 'add_new_input_fields.dart';


class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    ///Initializing focus node.
    focusNode = FocusNode();
    Provider.of<AddProjectProvider>(context, listen: false)
        .addingAddNewProjectsData();
    Provider.of<DashboardProvider>(context, listen: false)
        .addingDropDownValues();
  }

  @override
  void dispose() {
    ///Disposing focus node.
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddProjectProvider provider = Provider.of<AddProjectProvider>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    List<Widget> makeRadioListTile =
        Provider.of<EditProjectProvider>(context).makeRadioListTile(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: Insets.s7, bottom: Insets.s20, left: Insets.s30),
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
                Labels.addProject,
                style: textTheme.titleLarge!
                    .copyWith(color: colorTheme.onBackground),
              ),
              const SizedBox(
                height: 20,
              ),
              Focus(
                  onKey: CommonMethods.changeFormFieldFocus,
                  focusNode: focusNode,
                  child: Form(
                      autovalidateMode: AutovalidateMode.disabled,
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AddNewFormDropdownFields(
                              label: Labels.financialYear,
                              items: Provider.of<DashboardProvider>(context)
                                  .dropDownData1,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(children: [
                                  SizedBox(
                                    width: mQ.size.width / 8,
                                    child: RichText(
                                      text: TextSpan(
                                        text: Labels.selectProject,
                                        style: textTheme.bodyMedium!.copyWith(
                                            color: colorTheme.onPrimary),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ' *',
                                            style: textTheme.bodyMedium!
                                                .copyWith(
                                                    fontSize: Insets.s20,
                                                    color: colorTheme
                                                        .onTertiaryContainer),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mQ.size.width / 25,
                                  ),
                                  SizedBox(
                                    height: 48,
                                    width: 300,
                                    child: DropdownButtonFormField(
                                      isExpanded: true,
                                      hint: Text(
                                        Labels.pleaseSelect,
                                        style: textTheme.bodyMedium,
                                      ),
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              borderSide: BorderSide(
                                                width: 2,
                                              ))),
                                      icon: const Icon(
                                          MaterialIcons.keyboardArrowDown),
                                      items: provider.projectsDD.map(
                                        (AddNewProject value) {
                                          return DropdownMenuItem<String>(
                                            value: value.projectName,
                                            onTap: () {
                                              provider.getAddNewProjectDataById(
                                                  value.id);
                                            },
                                            child: Text(
                                              value.projectName.toString(),
                                              style: textTheme.bodyMedium,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {},
                                    ),
                                  )
                                ])),
                            AddNewFormInputFields(
                                label: Labels.clientName,
                                enableTextField: false,
                                initialValue: provider.clientNameInitialValue),
                            AddNewFormInputFields(
                                label: Labels.country,
                                enableTextField: false,
                                initialValue: provider.country),
                            AddNewFormInputFields(
                                label: Labels.currency,
                                enableTextField: false,
                                initialValue: provider.currency),
                            AddNewFormInputFields(
                                label: Labels.paymentTerm,
                                enableTextField: false,
                                initialValue: provider.paymentTerm),
                            AddNewFormInputFields(
                                label: Labels.businessUnit,
                                enableTextField: false,
                                initialValue: provider.businessUnit),
                            AddNewFormInputFields(
                                label: Labels.projectForecast,
                                enableTextField: true),
                            AddNewFormInputFields(
                                label: Labels.actualCost,
                                enableTextField: true),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: Insets.s10),
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: deviceWidth / 7.7,
                                      child: Text(
                                        Labels.status,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                                color: colorTheme.onPrimary),
                                      )),
                                  SizedBox(
                                    width: deviceWidth / 42.5,
                                  ),

                                  ///Radio buttons
                                  ...makeRadioListTile
                                ],
                              ),
                            )
                          ]))),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceWidth / 6.1),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          provider.postData(context);
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: Insets.s20,
                            bottom: Insets.s20,
                            left: Insets.s20,
                            right: Insets.s20)),
                      ),
                      child: const Text(
                        Labels.add,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
