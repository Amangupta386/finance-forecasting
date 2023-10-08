import 'package:ddofinance/widgets/add_new_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/projects/add_new_projects_provider.dart';
import 'package:ddofinance/widgets/add_new_input_fields.dart';
import 'package:ddofinance/widgets/appbar_widget.dart';
import 'package:ddofinance/widgets/go_back.dart';


class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  GlobalKey<FormState> formKey =  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    double deviceHeight = mQ.size.height;
    final theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    var provider = Provider.of<AddProjectProvider>(context);
    return  Scaffold(
      appBar:  const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:7.0,bottom: 20,left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const GoBack(),
              const SizedBox(height: 20,),
              Text('Add Project',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: colorTheme.onBackground),),
              const SizedBox(height: 20,),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddNewFormDropdownFields(label: 'Financial Year', items: provider.dropdownItems1,),
                    AddNewFormInputFields(label: 'Client Name'),
                    AddNewFormInputFields(label: 'Project Name', ),
                    AddNewFormDropdownFields(label: 'Country', items: provider.dropdownItems2,),
                    AddNewFormDropdownFields(label: 'Currency', items: provider.dropdownItems3,),
                    AddNewFormDropdownFields(label: 'Payment Team', items: provider.dropdownItems4,),
                    AddNewFormDropdownFields(label: 'Business Unit', items: provider.dropdownItems5,),
                    Padding(
                      padding: EdgeInsets.only(left:deviceWidth/6),
                      child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                formKey.currentState!.save();
                                // provider.saveData(context);
                              },
                              child:  const Text(
                                'Add',
                              )),
                          SizedBox(width: MediaQuery.of(context).size.width/10,),

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