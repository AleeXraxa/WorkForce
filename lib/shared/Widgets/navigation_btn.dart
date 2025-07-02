import 'package:workforce/Core/app_core.dart';

Widget navArrowButton({
  required VoidCallback onTap,
  required IconData icon,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(30.r),
    child: Container(
      width: 35.w,
      height: 35.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 15.sp,
      ),
    ),
  );
}
