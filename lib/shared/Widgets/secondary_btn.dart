import 'package:workforce/Core/app_core.dart';

class SecondaryBtn extends StatelessWidget {
  final String text;
  final Color bg;
  final VoidCallback onTap;
  const SecondaryBtn({
    super.key,
    required this.text,
    required this.bg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.secondaryBtn,
      ),
    );
  }
}
