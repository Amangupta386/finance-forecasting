import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FormDropdownFields extends StatefulWidget {
  final String label;
  const FormDropdownFields({Key? key, required this.label}) : super(key: key);

  @override
  State<FormDropdownFields> createState() => _FormDropdownFieldState();
}

class _FormDropdownFieldState extends State<FormDropdownFields> {
  String? selectedValue;
  String selectedLanguage1 = 'en';

  String selectedLanguage2 = 'hi';

  @override
  Widget build(BuildContext context) {

    final List<String> items = [
      'item1',
      'item2',
      'item3',
      'item4',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 8,
                  child: Text(
                    widget.label,
                    style: Theme.of(context).textTheme.titleSmall,
                  )),
            ],
          ),
          Container(
            height: 35,
            width: 265,
            child: DropdownButtonHideUnderline( // for hiding the button underline
              child: DropdownButton2<String>(// dropdown_button2: ^2.3.7

                hint: Text(
                  'Please select',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: items
                    .map((String option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}