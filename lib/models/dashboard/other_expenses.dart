import 'dart:convert';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/cupertino.dart';

List<OtherExpenseModel> otherExpenseModelFromJson(String str) =>
    List<OtherExpenseModel>.from(
        json.decode(str).map((x) => OtherExpenseModel.fromJson(x)));

String otherExpenseModelToJson(List<OtherExpenseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OtherExpenseModel {
  String label;
  List<MonthValue> monthValues;
  CustomDropdownModel customDropDown;
  bool isDropdownIndexOpen = false;

  OtherExpenseModel({
    required this.label,
    required this.monthValues,
    required this.customDropDown,
  });

  String get totalYTD {
    return '0';
  }
  String get totalYF {
    int total = 0;
    for (var element in monthValues) {
      try {
        total += int.parse(
            element.controller.text.isEmpty ? '0' : element.controller.text);
      } catch (e) {
        total += 0;
      }
    }
    return total.toString();
  }

  factory OtherExpenseModel.fromJson(Map<String, dynamic> json) =>
      OtherExpenseModel(
        label: json["label"],
        customDropDown: CustomDropdownModel(
            index: json['index'] ?? 0),
        monthValues: List<MonthValue>.from(
            json["monthValues"].map((x) => MonthValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "monthValues": List<dynamic>.from(monthValues.map((x) => x.toJson())),
      };
}

class MonthValue {
  String label;
  String value;
  TextEditingController controller;

  MonthValue({
    required this.label,
    required this.value,
    required this.controller,
  });

  bool get isValid =>
      TextFieldValidation.validateInput(controller.text) != '!';

  factory MonthValue.fromJson(Map<String, dynamic> json) => MonthValue(
        label: json["label"],
        value: json["value"].toString(),
        controller: TextEditingController(text: json["value"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}

class CustomDropdownModel {
  final int index;

  CustomDropdownModel({
    required this.index,
  });

  factory CustomDropdownModel.fromJson(Map<String, dynamic> json) {
    return CustomDropdownModel(
      index: json['index'] as int,

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
    };
  }
}
