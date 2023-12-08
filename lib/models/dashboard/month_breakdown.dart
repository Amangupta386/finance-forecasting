import 'dart:convert';
import 'package:ddofinance/utils/validators.dart';
import 'package:flutter/material.dart';

List<MonthBreakdownModel> monthBreakdownModelFromJson(String str) => List<MonthBreakdownModel>.from(json.decode(str).map((x) => MonthBreakdownModel.fromJson(x)));

String monthBreakdownModelToJson(List<MonthBreakdownModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonthBreakdownModel {
  String label;
  List<MonthValue> monthValues;
  bool isSelect = false;

  String get totalYTD {
    return '0';
  }
  String get totalFY {
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

  bool isTotalSelected = false;
  bool selectRowMonth = false;
  bool isDottedLine = false;
  bool isSelectIconHide = false;
  void selectRow() {
    isTotalSelected = !isTotalSelected;
    isSelect = isTotalSelected;
  }



  MonthBreakdownModel({
    required this.label,
    required this.monthValues,
    required this.isDottedLine,
  });

  factory MonthBreakdownModel.fromJson(Map<String, dynamic> json) => MonthBreakdownModel(
    label: json["label"],
    monthValues: List<MonthValue>.from(json["monthValues"].map((x) => MonthValue.fromJson(x))),
    isDottedLine: json['isDottedLine'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "monthValues": List<dynamic>.from(monthValues.map((x) => x.toJson())),
    "isDottedLine": isDottedLine,
  };
}

class MonthValue {
  String label;
  String value;
  String commentData;
  TextEditingController controller;
  bool  monthBlock = false;
  bool get isValid =>
      TextFieldValidation.validateInput(controller.text) != '!';
  bool monthIcon = false;
  bool selectRowMonth = false;

  MonthValue({
    required this.label,
    required this.value,
    required this.commentData,
    required this.controller,
  });

  factory MonthValue.fromJson(Map<String, dynamic> json) => MonthValue(
    label: json["label"],
    value: json["value"].toString(),
    commentData: json["commentData"],
    controller: TextEditingController(text: json["value"].toString()),
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
    "commentData": commentData,
  };
}
