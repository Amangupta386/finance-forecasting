import 'dart:convert';

import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/material.dart';

List<ResourceCostModel> resourceCostModelFromJson(String str) => List<ResourceCostModel>.from(json.decode(str).map((x) => ResourceCostModel.fromJson(x)));

String resourceCostModelToJson(List<ResourceCostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResourceCostModel {
  String label;
  List<MonthValue> monthValues;

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

  ResourceCostModel({
    required this.label,
    required this.monthValues,
  });

  factory ResourceCostModel.fromJson(Map<String, dynamic> json) => ResourceCostModel(
    label: json["label"],
    monthValues: List<MonthValue>.from(json["monthValues"].map((x) => MonthValue.fromJson(x))),
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
    required this.controller
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
