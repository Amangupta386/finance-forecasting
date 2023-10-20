class Labels {
  /// project page constant
  static const String projects = 'Projects',
      addNew = 'Add New',
      searchBoxHintText = 'Search client name or project name',
      edit = 'Edit';

  ///data table const
  static const String clientName = 'Client Name',
      projectName = 'Project Name',
      projectForecast = 'Project Forecast',
      actualCost = 'Actual Cost',
      status = 'Status',
      action = 'Action',
      startDate = 'Start Date',
      endDate = 'End Date',
      resourceCost = 'Resource Cost';

  ///Appbar const
  static const String welcomeBack = 'Welcome Back ',
      admin = 'Admin!',
      logout = 'logout';

  ///Navigation Rail constant
  static const String railDashboard = 'Dashboard',
      project = 'Project',
      resources = 'Resources';

  ///Login Page constant
  static const String login = 'Login',
      loginMessage = 'Hey, enter your details to login into your accounts',
      email = 'Email Address',
      password = 'Password';

  ///  Resources page constant
  static const String resourcesHeading = 'Resources Allocation',
      resourceSearchMessage = 'Search employee, client and project Name';

  ///and take the above datatable constant

  ///logout Message By Custom Snackbar
  static const String logoutCustomMessage =
      'You have been logged out Successfully';

  ///Wrong Credentials Message By Custom Snackbar
  static const String wrongCredentialsMessage =
      'You have entered wrong credentials';

  ///Can't connect to server.
  static const String unableToConnect = 'Unable To Connect to the Server',
                  checkYourConnection = 'check your Internet connection';

  //Edit projects screen const
  static const String editProject = 'Edit Project',
      inProgress = 'In-Progress',
      completed = 'Completed',
      financialYear = 'Financial Year',
      country = 'Country',
      currency = 'Currency',
      paymentTeam = 'Payment Team',
      businessUnit = 'Business Unit',
      projectActualCost = 'Project Actual Cost';

  //Constants used in dashboard screen
  static const bu = 'BU', client = 'Client', show = 'Show';
  static const save = 'Save', cancel = 'Cancel';

  //Constants used in projects screen
  static const goBack = 'Go Back', projectLabel = 'Project - ';

  //Constants used in resources cost screen
  static const resourcesCost = 'Resources Cost',
      uploadFile = 'Upload File',
      searchEmployee = 'Search employee',
      employeeId = 'Employee ID',
      employeeName = 'Employee Name';

  ///Constants used in dashboard screen
  static const dashBoard = 'DashBoard';

  ///Constants used in resources cost screen
  static const designation = 'Designation',
      joiningDate = 'Joining Date',
      monthlyCostComp1 = 'Monthly Cost Comp1',
      monthlyCostComp2 = 'Monthly Cost Comp2',
      monthlyCostComp3 = 'Monthly Cost Comp3',
      monthlyCostComp4 = 'Monthly Cost Comp4';

  static const String blankString = '';

// Data Table String Constant
  static const String monthByMonthBreakdown = 'MONTH BY MONTH BREAKDOWN',
      monthByMonthBreakDownAndroid = 'MONTH BY MONTH\nBREAKDOWN',
      otherExpense = 'OTHER EXPENSES',
      resourceCostHeading = 'RESOURCE COST';

  static const String totalFY = 'Total FY',
      totalYTD = 'Total YTD',
      forecastedRevenue = 'Forecasted Revenue',
      actualRevenue = 'Actual Revenue',
      forecastedCollection = 'Forecasted Collection',
      actualCollection = 'Actual Collection',
      monthlyCost = 'Monthly Cost',
      monthlyDeviation = 'Monthly Deviation',
      forecastedRevenueResponsive = 'Forecasted\nRevenue',
      actualRevenueResponsive = 'Actual\nRevenue',
      forecastedCollectionResponsive = 'Forecasted\nCollection',
      actualCollectionResponsive = 'Actual\nCollection',
      monthlyCostResponsive = 'Monthly\nCost',
      monthlyDeviationResponsive = 'Monthly\nDeviation',
      totalFYResponsive = 'Total\nFY',
      totalYTDResponsive = 'Total\nYTD';

  static const String monthBreakdownTextField= 'MonthBreakdownTextField';
  static const String expenseMonthTextField = 'ExpenseMonthTextField';
  static const String resourceMonthTextField = 'ResourceMonthTextField';
  static const String addRowExpenseMonthTextField = 'AddRowExpenseMonthTextField';


  static const String april = 'Apr',
      may = 'May',
      june = 'Jun',
      july = 'Jul',
      august = 'Aug',
      september = 'Sept',
      october = 'Oct',
      november = 'Nov',
      december = 'Dec',
      january = 'Jan',
      february = 'Feb',
      march = 'Mar';
  // static

  
  static const String travelExpense = 'Travel Expenses';
      static const hotelAccommodation = 'Hotel Accommodation';
      static const teamMeeting = 'Team Meeting';
      static const teamLunch = 'Team Lunch';
      static String searchQuery = '';

  static List<String> developerList = [
    for (int i = 1; i <= 100; i++) 'Developer $i'
  ];

  static const String showMore = 'Show More', addMore = '+Add More';

  static const String add = 'Add', addComment = 'Add Comment';
}
