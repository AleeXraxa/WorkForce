import 'package:workforce/Core/app_core.dart';

class PrimaryBtn extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  const PrimaryBtn({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.7.sw,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          backgroundColor: bgColor, // Solid Primary Color
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
