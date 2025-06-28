import 'package:workforce/Core/app_core.dart';

class CustomField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isObscure;
  final String? Function(String?)? validator;
  final IconData? prefix;
  final IconData? suffix;
  final TextInputType type;
  final VoidCallback? ontap;
  final String? prefixText;

  const CustomField({
    required this.labelText,
    required this.controller,
    required this.validator,
    this.suffix,
    this.prefix,
    this.isObscure = false,
    this.type = TextInputType.text,
    this.ontap,
    this.prefixText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isObscure,
      validator: validator,
      decoration: InputDecoration(
          prefixText: prefixText,
          prefixIcon: prefix != null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: FaIcon(prefix, size: 20),
                )
              : null,
          suffixIcon: suffix != null
              ? GestureDetector(
                  onTap: ontap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: FaIcon(suffix, size: 20),
                  ),
                )
              : null,
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Appcolors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Appcolors.screenBG, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          labelText: labelText,
          labelStyle: AppTextStyles.textfieldStyle),
    );
  }
}
