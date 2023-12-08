import 'package:flutter/material.dart';

class CategorySubcategoryAlert extends StatefulWidget {
  final List<Widget> widgetList;
  final GlobalKey<FormState> formKey;
  const CategorySubcategoryAlert(
      {super.key, required this.widgetList, required this.formKey});

  @override
  State<CategorySubcategoryAlert> createState() =>
      _CategorySubcategoryAlertState();
}

class _CategorySubcategoryAlertState extends State<CategorySubcategoryAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 200,
        width: 400,
        child: Form(
          key: widget.formKey,
          child: Column(children: widget.widgetList),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.formKey.currentState!.save();

            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
