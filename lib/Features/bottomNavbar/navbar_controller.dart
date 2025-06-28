import 'package:workforce/Core/app_core.dart';

class MainNavController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  late List<RoleBasedNavItem> navItems;

  void setRoleBasedItems(String role) {
    switch (role) {
      case 'Admin':
        navItems = [
          RoleBasedNavItem(
              screen: AdminDashboard(),
              icon: const Icon(Icons.dashboard, color: Colors.white)),
          RoleBasedNavItem(
              screen: AddUser(),
              icon: const Icon(Icons.group, color: Colors.white)),
          RoleBasedNavItem(
              screen: AdminDashboard(),
              icon: const Icon(Icons.history, color: Colors.white)),
          RoleBasedNavItem(
              screen: AdminDashboard(),
              icon: const Icon(Icons.settings, color: Colors.white)),
        ];
        break;

      // case 'Employee':
      //   navItems = [
      //     RoleBasedNavItem(
      //         screen: EmployeeDashboard(),
      //         icon: const Icon(Icons.dashboard, color: Colors.white)),
      //     RoleBasedNavItem(
      //         screen: TaskList(),
      //         icon: const Icon(Icons.task, color: Colors.white)),
      //     RoleBasedNavItem(
      //         screen: AttendanceScreen(),
      //         icon: const Icon(Icons.check_circle, color: Colors.white)),
      //     RoleBasedNavItem(
      //         screen: EmployeeSettings(),
      //         icon: const Icon(Icons.settings, color: Colors.white)),
      //   ];
      //   break;

      // case 'Client':
      //   navItems = [
      //     RoleBasedNavItem(
      //         screen: ClientDashboard(),
      //         icon: const Icon(Icons.dashboard, color: Colors.white)),
      //     RoleBasedNavItem(
      //         screen: ProjectList(),
      //         icon: const Icon(Icons.list, color: Colors.white)),
      //     RoleBasedNavItem(
      //         screen: SupportScreen(),
      //         icon: const Icon(Icons.support, color: Colors.white)),
      //   ];
      //   break;
    }
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
