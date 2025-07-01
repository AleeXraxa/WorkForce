import 'package:workforce/Core/app_core.dart';

class StatCards extends StatelessWidget {
  const StatCards({
    super.key,
    required this.controller,
  });

  final AdminController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 20,
      childAspectRatio: 1.12,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        StatCard(
          icon: FontAwesomeIcons.userTie,
          title: 'Total Employees',
          count: controller.totalEmployees.value,
        ),
        StatCard(
          icon: FontAwesomeIcons.peopleGroup,
          title: 'Total Leads',
          count: controller.totalEmployees.value,
        ),
        StatCard(
          icon: FontAwesomeIcons.listCheck,
          title: 'Pending Tasks',
          count: controller.totalEmployees.value,
        ),
        StatCard(
          icon: FontAwesomeIcons.briefcase,
          title: 'Total Projects',
          count: controller.totalEmployees.value,
        ),
      ],
    );
  }
}
