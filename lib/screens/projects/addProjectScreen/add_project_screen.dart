import 'package:ddofinance/providers/dashboard/dashboard_provider.dart';
import 'package:ddofinance/widgets/add_new_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/projects/add_new_projects_provider.dart';
import 'package:ddofinance/widgets/add_new_input_fields.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:ddofinance/widgets/go_back.dart';
import '../../../models/projects/add_new_project.dart';
import '../../../theme/styles.dart';
import '../../../utils/constants/material_icons.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  // Future<void> onClick() async {
  //   var projectsProvider =
  //       Provider.of<ProjectsProvider>(context, listen: false);
  //       projectsProvider.afterViewBuild1();
  //      projectsProvider.projectsData1 =
  //       projectsProvider.dataFromLocalStorageFuture1;
  //   projectsProvider.notifyListeners();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AddProjectProvider>(context, listen: false)
        .addingAddNewProjectsData();
    Provider.of<DashboardProvider>(context, listen: false)
        .addingDropDownValues();
  }

  @override
  Widget build(BuildContext context) {
    GoRouter.of(context).refresh();
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    var provider = Provider.of<AddProjectProvider>(context);
    var makeRaioListTile = provider.makeRadioListTile(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 7.0, bottom: 20, left: 30),
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
                'Add Project',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: colorTheme.onBackground),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddNewFormDropdownFields(
                      label: 'Financial Year',
                      items:
                      Provider.of<DashboardProvider>(context).dropDownData1,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(children: [
                          SizedBox(
                            width: mQ.size.width / 8,
                            child: RichText(
                              text: TextSpan(
                                text: 'Select Project',
                                style: textTheme.bodyMedium!
                                    .copyWith(color: colorTheme.onPrimary),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' *',
                                    style: textTheme.bodyMedium!.copyWith(
                                        fontSize: Insets.s20,
                                        color: colorTheme.onTertiaryContainer),
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
                                'Please Select',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                      borderSide: BorderSide(
                                        width: 2,
                                      ))),
                              icon: const Icon(MaterialIcons.keyboardArrowDown),
                              items: provider.projectsDD.map(
                                    (AddNewProject value) {
                                  return DropdownMenuItem<String>(
                                    value: value.projectName,
                                    onTap: () {
                                      // print(value.id);
                                      provider
                                          .getAddNewProjectDataById(value.id);
                                    },
                                    child: Text(
                                      value.projectName.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                // Provider.of<AddProjectProvider>(context,listen: false).updateUserFields(value!);
                              },
                              onSaved: (val) {},
                            ),
                          )
                        ])),
                    AddNewFormInputFields(
                        label: 'Client Name',
                        enableTextField: false,
                        initialValue: provider.clientNameInitialValue),
                    AddNewFormInputFields(
                        label: 'Country',
                        enableTextField: false,
                        initialValue: provider.country),
                    AddNewFormInputFields(
                        label: 'Currency',
                        enableTextField: false,
                        initialValue: provider.currency),
                    AddNewFormInputFields(
                        label: 'Payment Team',
                        enableTextField: false,
                        initialValue: provider.paymentTerm),
                    AddNewFormInputFields(
                        label: 'Business Unit',
                        enableTextField: false,
                        initialValue: provider.businessUnit),
                    AddNewFormInputFields(
                        label: 'Project Forecast', enableTextField: true),
                    AddNewFormInputFields(
                        label: 'Actual Cost', enableTextField: true),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Status',
                          style: textTheme.bodyMedium!
                              .copyWith(color: colorTheme.onPrimary),
                        ),
                        const SizedBox(
                          width: 185,
                        ),
                        ...makeRaioListTile,
                      ],
                    ),
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
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.only(
                                      top: Insets.s20,
                                      bottom: Insets.s20,
                                      left: Insets.s20,
                                      right: Insets.s20)),
                            ),
                            child: const Text(
                              'Add',
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 10,
                          ),
                        ],
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
