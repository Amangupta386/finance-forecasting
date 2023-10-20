import 'dart:ui';
import 'package:ddofinance/models/projects/grid_data_model.dart';

List<Map<String, dynamic>> data = [
  {
    'clientName': 'Strategen',
    'ProjectName': 'Strategen',
    'ProjectForecast': '\$35890',
    'ActualCost': '\$32800',
    'status': 'In-Progress'
  },
  {
    'clientName': 'CGC-CPT',
    'ProjectName': 'Shuttle Mobile App',
    'ProjectForecast': '\$1,20,500',
    'ActualCost': '\$1,99,230',
    'status': 'In-Progress'
  },
  {
    'clientName': 'AdFactors',
    'ProjectName': 'ChatGPT',
    'ProjectForecast': '\$14,420',
    'ActualCost': '\$14,420',
    'status': 'Completed'
  },
  {
    'clientName': 'Scaled Foundations',
    'ProjectName': 'Files Management Application',
    'ProjectForecast': '\$8,185',
    'ActualCost': '\$8,185',
    'status': 'In-Progress'
  },
];

List<KeyValueObject>gridData = [
  KeyValueObject('forecasted revenue', '25,200', const Color.fromRGBO(2, 50, 144, 0.05)),
  KeyValueObject('actual revenue', '20,356', const Color.fromRGBO(2, 50, 144, 0.05)),
  KeyValueObject('forecasted collection', '23,890', const Color.fromRGBO(2, 50, 144, 0.05)),
  KeyValueObject('actual collection', '19,700', const Color.fromRGBO(0, 173, 47, 0.1)),
  KeyValueObject('forecasted revenue deviation', '-3,750', const Color.fromRGBO(255, 0, 0, 0.05)),
  KeyValueObject('actual revenue deviation','-4,750', const Color.fromRGBO(255, 0, 0, 0.05)),
];