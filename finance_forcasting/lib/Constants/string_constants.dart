

const List<String> columnTitles = ['', 'Total FY', 'Total YTD'];

const textFieldValue = '\$ 0';

const List names = [
  'Forecasted Revenue',
  'Actual Revenue',
  'Forecasted Collection',
  'Actual Collection',
  'Monthly Cost',
  'Monthly Deviation'
];
int length = names.length;
const lastElement =  'Monthly Deviation';
const List monthsColumnsNames = [
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sept',
  'Oct',
  'Nov',
  'Dec',
  'Jan',
  'Feb',
  'Mar'
];

List<List<bool>> totalList  =[
List.filled(length, true),   // totalFY
List.filled(length, true),   // totalYTD
];

List<List<bool>> eachBlock = [
  List.filled(length, false),  // aprList
  List.filled(length, false),  // mayList
  List.filled(length, false),  // junList
  List.filled(length, false),  // julList
  List.filled(length, false),  // augList
  List.filled(length, false),  // septList
  List.filled(length, false),  // octList
  List.filled(length, false),  // novList
  List.filled(length, false),  // decList
  List.filled(length, false),  // janList
  List.filled(length, false),  // febList
  List.filled(length, false),  // marList
];
List<List<bool>> eachComment = [
  List.filled(length, false),  // aprList
  List.filled(length, false),  // mayList
  List.filled(length, false),  // junList
  List.filled(length, false),  // julList
  List.filled(length, false),  // augList
  List.filled(length, false),  // septList
  List.filled(length, false),  // octList
  List.filled(length, false),  // novList
  List.filled(length, false),  // decList
  List.filled(length, false),  // janList
  List.filled(length, false),  // febList
  List.filled(length, false),
];


List<bool> onHoverIcon = List.filled(5, false);

List<bool> isSelected = List<bool>.generate(length, (int index) => false);



List<List<bool>> cellVisibility = List.generate(
  length,
      (index) => List.generate(12, (index) => false),
);

