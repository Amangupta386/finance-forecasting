///Data model used for resources cost data table.
class ResourcesCostModel {
  final String eId;
  final String eName;
  final String designation;
  final String joiningDate;
  String cost1;
  String cost2;
  String cost3;
  String cost4;

  ///Calling the constructor of [ResourcesCostModel].
  ResourcesCostModel(
      {required this.eId,
        required this.eName,
        required this.designation,
        required this.joiningDate,
        required this.cost1,
        required this.cost2,
        required this.cost3,
        required this.cost4});

  /// Converts this object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'eId': eId,
      'eName': eName,
      'designation': designation,
      'joiningDate': joiningDate,
      'cost1': cost1,
      'cost2': cost2,
      'cost3': cost3,
      'cost4': cost4,
    };
  }

  /// Factory method for creating a ResourcesCostModel instance from a JSON map.
  factory ResourcesCostModel.fromJson(Map<String, dynamic> json) {
    return ResourcesCostModel(
      eId: json['eId'],
      eName: json['eName'],
      designation: json['designation'],
      joiningDate: json['joiningDate'],
      cost1: json['cost1'],
      cost2: json['cost2'],
      cost3: json['cost3'],
      cost4: json['cost4'],
    );
  }
}