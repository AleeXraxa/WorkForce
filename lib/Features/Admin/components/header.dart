import 'package:workforce/Core/app_core.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome Back, ${user?.username ?? 'User'} ',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Role: ${user?.role ?? 'N/A'} | ID: 0001',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
