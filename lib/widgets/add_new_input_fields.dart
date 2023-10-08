import 'package:flutter/material.dart';
import 'package:ddofinance/theme/color_constants.dart';
import 'package:ddofinance/theme/styles.dart';


/// A widget for displaying a form input field with a label
class AddNewFormInputFields extends StatefulWidget {
  // final int index;
  // final bool enableTextField;
  final String label;
  // String initialValue;
  // TextEditingController textEditingController;

  /// Creates a [AddNewFormInputFields] widget.
  ///
  /// The label to display next to the input field.
  /// A boolean flag to determine if the text field is enabled.
  /// The initial value of the text field.
  /// A controller for the text editing of the input field.
  AddNewFormInputFields({
    Key? key,
    // required this.enableTextField,
    required this.label
    // required this.initialValue,
    // required this.textEditingController, required this.index,
  }) : super(key: key);

  @override
  State<AddNewFormInputFields> createState() => _AddNewFormInputFieldsState();
}

class _AddNewFormInputFieldsState extends State<AddNewFormInputFields> {

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<EditProjectScreenData>(context);
    MediaQueryData mQ = MediaQuery.of(context);
    ThemeData theme = Theme.of(context);
    return Padding(
      padding:   EdgeInsets.symmetric(vertical:Insets.s10),
      child: Row(
        children: [
          SizedBox(
              width: mQ.size.width / 8,
              child: Text(
                widget.label,
                style: theme.textTheme.titleSmall!.copyWith(color: kGrey),
              )),
          SizedBox(
            width: mQ.size.width / 25,
          ),
          SizedBox(
            height: 48,
            width: 300,
            child:  TextFormField(
              // enabled: widget.enableTextField,
              // controller: widget.textEditingController,
              onSaved: (value) {
                // widget.initialValue = value!;
                // provider.addSelectedValues.add(widget.initialValue);
                // Provider.of<ProjectsScreenProvider>(context,listen: false).addingDataFromEditScreen.add(value);
                // Provider.of<ProjectsScreenProvider>(context,listen: false).changeTableDataFromEditScreen(widget.index);
                // Provider.of<ProjectsScreenProvider>(context).changeTableDataFromEditScreen(widget.index);
              },
              style:
              Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color:  kLightGrey),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                          width: 2,
                          color: kOffWhite))),
            ),

          )
        ],
      ),
    );
  }
}
