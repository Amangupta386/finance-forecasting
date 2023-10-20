import 'package:ddofinance/models/resources_cost/resources_cost_model.dart';
import 'package:ddofinance/utils/constants/labels.dart';

final List<String> tableLabels = [
  Labels.employeeId,
  Labels.employeeName,
  Labels.designation,
  Labels.joiningDate,
  Labels.monthlyCostComp1,
  Labels.monthlyCostComp2,
  Labels.monthlyCostComp3,
  Labels.monthlyCostComp4
];

final List<ResourcesCostModel> resourcesData = [
  ResourcesCostModel(eId: '25190972', eName: 'Harish Sharma', designation: 'UI/UX Lead', joiningDate: '20/05/2023',  cost1: '0', cost2: '0', cost3: '0', cost4: '0'),
  ResourcesCostModel(eId: '30789014', eName: 'Pragati Singh', designation: 'Front End Developer', joiningDate: '08/03/2021', cost1: '0', cost2: '0', cost3: '0', cost4: '0'),
  ResourcesCostModel(eId: '12089087', eName: 'Raj Kumar', designation: 'Mobile App Developer', joiningDate: '24/04/2023', cost1: '0', cost2: '0', cost3: '0', cost4: '0'),
  ResourcesCostModel(eId: '40903902', eName: 'Mohammad Akram', designation: 'Quality Engineer', joiningDate: '11/02/2020', cost1: '0', cost2: '0', cost3: '0', cost4: '0')
];