import 'package:workforce/Core/app_core.dart';

class RoleBasedNavBar extends StatelessWidget {
  final String userRole;
  final MainNavController controller = Get.put(MainNavController());

  RoleBasedNavBar({super.key, required this.userRole}) {
    controller.setRoleBasedItems(userRole);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          extendBody: true,
          body: controller.navItems[controller.selectedIndex.value].screen,
          bottomNavigationBar: CurvedNavigationBar(
            index: controller.selectedIndex.value,
            onTap: controller.changeTab,
            height: 60,
            backgroundColor: Colors.transparent,
            color: Appcolors.primaryColor,
            buttonBackgroundColor: Colors.deepPurple,
            animationDuration: const Duration(milliseconds: 300),
            items: controller.navItems.map((item) => item.icon).toList(),
          ),
        ));
  }
}
