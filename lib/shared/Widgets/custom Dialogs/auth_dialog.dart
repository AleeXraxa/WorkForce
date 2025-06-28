import 'package:workforce/Core/app_core.dart';

void showAuthDialog({
  required String title,
  required String subtitle,
  required IconData icon,
  required VoidCallback onConfirm,
  required String btnText,
}) {
  Get.defaultDialog(
    title: "",
    contentPadding: const EdgeInsets.all(20),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(icon, size: 40, color: Colors.blue),
        const SizedBox(height: 16),
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        PrimaryBtn(
            btnText: btnText,
            onTap: onConfirm,
            bgColor: Appcolors.primaryColor),
      ],
    ),
    radius: 10,
  );
}
