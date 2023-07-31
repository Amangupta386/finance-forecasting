import 'package:finance_forecasting/task_2/widgets/form_input_field.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/form_Drop_Down_Field.dart';
import '../widgets/go_back.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key}) : super(key: key);

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:7.0,bottom: 20,left: 30),
          child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  const GoBack(),
                  const SizedBox(height: 20,),
                  Text('Add Project',style: Theme.of(context).textTheme.titleLarge,),
                  const SizedBox(height: 20,),
                  const FormDropdownFields(label: 'Financial Year'),
                  const FormInputFields(label: 'Client Name'),
                  const FormInputFields(label: 'Project Name'),
                  const FormDropdownFields(label: 'Country'),
                  const FormDropdownFields(label: 'Currency'),
                  const FormDropdownFields(label: 'Payment Team'),
                  const FormDropdownFields(label: 'Business Unit'),
                  Padding(
                    padding: const EdgeInsets.only(left:198.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child:  const Text(
                              'Add',
                            )),
                        SizedBox(width: MediaQuery.of(context).size.width/10,),

                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}