import 'dart:ui';

class DataTableChartModel {
  int index;
  List<String> forecastedRevenue;
  List<String> actualRevenue;
  List<String> forecastedCollection;
  List<String> actualCollection;
  List<String> monthlyCost;
  List<String> dottedLine1;
  List<String> monthlyDeviation;
  List<String> dottedLine2;

  DataTableChartModel({
    required this.forecastedRevenue,
    required this.index,
    required this.actualRevenue,
    required this.forecastedCollection,
    required this.actualCollection,
    required this.monthlyCost,
    required this.dottedLine1,
    required this.monthlyDeviation,
    required this.dottedLine2,
  });

  // Create a factory constructor to deserialize JSON into a DataRowModel object
  factory DataTableChartModel.fromJson(Map<String, dynamic> json) {
    return DataTableChartModel(
      index: json['index'] as int,
      forecastedRevenue: List<String>.from(json['forecastedRevenue']),
      actualRevenue: List<String>.from(json['actualRevenue']),
      forecastedCollection: List<String>.from(json['forecastedCollection']),
      actualCollection: List<String>.from(json['actualCollection']),
      monthlyCost: List<String>.from(json['monthlyCost']),
      dottedLine1: List<String>.from(json['dottedLine1']),
      monthlyDeviation: List<String>.from(json['monthlyDeviation']),
      dottedLine2: List<String>.from(json['dottedLine2']),
    );
  }

  // Create a method to serialize a DataRowModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'forecastedRevenue': forecastedRevenue,
      'actualRevenue': actualRevenue,
      'forecastedCollection': forecastedCollection,
      'actualCollection': actualCollection,
      'monthlyCost': monthlyCost,
      'dottedLine1': dottedLine1,
      'monthlyDeviation': monthlyDeviation,
      'dottedLine2': dottedLine2,
    };
  }
}

///Model used for grid.
class KeyValueObject {
  final String key;
  final String value;
  final Color color;

  ///Calling the constructor of [KeyValueObject].
  KeyValueObject(this.key, this.value, this.color);
}