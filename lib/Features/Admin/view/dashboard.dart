import 'package:workforce/Core/app_core.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final controller = Get.find<AdminController>();

  @override
  void initState() {
    super.initState();
    controller.loadCurrentUser();
    controller.fetchDashboardStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    final user = controller.currentUserData.value;

                    if (user == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Header(user: user);
                  }),
                  SizedBox(height: 0.03.sh),
                  StatCards(controller: controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
