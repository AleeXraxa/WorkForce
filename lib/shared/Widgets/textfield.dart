import 'package:workforce/Core/app_core.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData? suffix;
  final bool isPass;
  final VoidCallback? onSuffixTap;
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.suffix,
    this.isPass = false,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppTextStyles.labelText),
        SizedBox(height: 0.01.sh),
        TextFormField(
          obscureText: isPass,
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 11.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: suffix != null
                ? IconButton(
                    onPressed: onSuffixTap,
                    icon: FaIcon(suffix),
                  )
                : null,
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}
