import 'dart:ui';
import 'package:ddofinance/models/projects/grid_data_model.dart';

List<KeyValueObject> gridData = [
  KeyValueObject(
      'forecasted revenue', '25,200', const Color.fromRGBO(2, 50, 144, 0.05)),
  KeyValueObject(
      'actual revenue', '20,356', const Color.fromRGBO(2, 50, 144, 0.05)),
  KeyValueObject('forecasted collection', '23,890',
      const Color.fromRGBO(2, 50, 144, 0.05)),
  KeyValueObject(
      'actual collection', '19,700', const Color.fromRGBO(0, 173, 47, 0.1)),
  KeyValueObject('forecasted revenue deviation', '-3,750',
      const Color.fromRGBO(255, 0, 0, 0.05)),
  KeyValueObject('actual revenue deviation', '-4,750',
      const Color.fromRGBO(255, 0, 0, 0.05)),
];
