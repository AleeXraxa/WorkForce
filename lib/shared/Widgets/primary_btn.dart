import '../../Core/app_core.dart';

class PrimaryBtn extends StatelessWidget {
  final String btnText;
  final VoidCallback onTap;
  final Color bgColor;

  const PrimaryBtn({
    required this.btnText,
    required this.onTap,
    required this.bgColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              elevation: 5,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
          onPressed: onTap,
          child: Text(
            btnText,
            style: AppTextStyles.primaryBtnText,
          )),
    );
  }
}
