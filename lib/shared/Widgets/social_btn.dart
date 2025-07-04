import 'package:workforce/Core/app_core.dart';

class SocialBtn extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;
  const SocialBtn({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.75.sw,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 20.w,
              height: 20.w,
            ),
            SizedBox(width: 10.w),
            Text(
              text,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
