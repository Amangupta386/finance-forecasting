import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/providers/projects/edit_project_provider.dart';
import 'package:ddofinance/theme/styles.dart';

import '../../../utils/constants/labels.dart';

/// A widget for displaying a form input field with a label
class FormInputFields extends StatefulWidget {
  final int index;
  final bool enableTextField;
  final String label;
  String initialValue;

  /// Creates a [FormInputFields] widget.
  ///
  /// The label to display next to the input field.
  /// A boolean flag to determine if the text field is enabled.
  /// The initial value of the text field.
  /// A controller for the text editing of the input field.
  FormInputFields({
    Key? key,
    required this.enableTextField,
    required this.label,
    required this.initialValue,
    required this.index,
  }) : super(key: key);

  @override
  State<FormInputFields> createState() => _FormInputFieldsState();
}




class _FormInputFieldsState extends State<FormInputFields> {
   late TextEditingController controller;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   controller =  TextEditingController(text: widget.initialValue);
  }
  @override
  Widget build(BuildContext context) {

    EditProjectProvider provider = Provider.of<EditProjectProvider>(context);
    ProjectsProvider projectsProvider=Provider.of<ProjectsProvider>(context, listen: false);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final theme = Theme.of(context);
    final textTheme=theme.textTheme;
    final ColorScheme colorTheme = theme.colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Insets.s10),
      child: Row(
        children: [
          SizedBox(
              width: deviceWidth / 8,
              child:  (widget.enableTextField)
                  ? RichText(
                text: TextSpan(
                  text: widget.label,
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
              )
                  : Text(
                widget.label,
                style: textTheme.bodyMedium!
                    .copyWith(color: colorTheme.onPrimary),
              )


          ),
          SizedBox(
            width: deviceWidth / 25,
          ),
          SizedBox(
            height: 48,
            width: 300,
            child: TextFormField(
              style: (widget.enableTextField)
                  ? textTheme.bodyMedium
                  :textTheme
                      .bodyMedium!
                      .copyWith(color: colorTheme.onPrimary),
              enabled: widget.enableTextField,
              controller: controller,
              onSaved: (value) {

                if(widget.label ==Labels.projectForecast){
                  provider.projectForecast =value!;

                }
                else if(widget.label ==Labels.projectActualCost){
                  provider.actualCost=value!;
                }



                // provider.addSelectedValues.add(value!);
                // projectsProvider.addingDataFromEditScreen
                //     .add(value);
                ///This method is changing the values from Edit screen to projects screen
                // projectsProvider.changeTableDataFromEditScreen(widget.index);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                          width: 2,
                          color:
                              (widget.enableTextField) ? colorTheme.onPrimary : colorTheme.tertiary))),
            ),
          )
        ],
      ),
    );
  }
}
