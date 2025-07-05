import 'package:workforce/Core/app_core.dart';

void showSuccessDialog(String title, String message) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              FontAwesomeIcons.solidCircleCheck,
              color: AppColors.primaryColor,
              size: 60.sp,
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: AppTextStyles.heading.copyWith(
                fontSize: 18.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              style: AppTextStyles.subtext.copyWith(
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            PrimaryBtn(
              text: 'OK',
              bgColor: AppColors.primaryColor,
              textColor: Colors.white,
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
