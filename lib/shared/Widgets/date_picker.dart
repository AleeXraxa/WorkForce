import 'package:intl/intl.dart';
import 'package:workforce/Core/app_core.dart';

class CustomDatePickerField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? prefix;
  final IconData? suffix;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CustomDatePickerField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.prefix,
    this.suffix = FontAwesomeIcons.calendar,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: controller,
      validator: validator,
      onTap: () async {
        FocusScope.of(context).unfocus();
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: firstDate ?? DateTime(1950),
          lastDate: lastDate ?? DateTime.now(),
        );
        if (pickedDate != null) {
          controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
      decoration: InputDecoration(
        prefixIcon: prefix != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: FaIcon(prefix, size: 20),
              )
            : null,
        suffixIcon: suffix != null
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: FaIcon(suffix, size: 20),
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
        labelStyle: AppTextStyles.textfieldStyle,
      ),
    );
  }
}
