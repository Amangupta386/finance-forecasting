import 'package:ddofinance/models/projects/project.dart';

class ProjectsData {
  ProjectsData();

  final List<ProjectsModel> data = [
    ProjectsModel(
        id: 1,
        clientName: 'Strategen',
        projectName: 'Strategen',
        projectForecast: 35890,
        actualCost: 32800,
        status: 'In-Progress',
        action: 'Edit'),
    ProjectsModel(
        id: 2,
        clientName: 'CGC-CPT',
        projectName: 'Shuttle Mobile App',
        projectForecast: 120500,
        actualCost: 199230,
        status: 'In-Progress',
        action: 'Edit'),
    ProjectsModel(
        id: 3,
        clientName: 'AdFactors',
        projectName: 'ChatGPT',
        projectForecast: 14420,
        actualCost: 14420,
        status: 'Completed',
        action: 'Edit'),
    ProjectsModel(
        id: 4,
        clientName: 'Scaled Foundations',
        projectName: 'Files Management Application',
        projectForecast: 8185,
        actualCost: 8185,
        status: 'In-Progress',
        action: 'Edit'),
  ];

}