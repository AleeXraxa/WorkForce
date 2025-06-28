import 'package:firebase_core/firebase_core.dart';
import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/bottomNavbar/navbar.dart';
import 'package:workforce/firebase_options.dart';
import 'package:workforce/shared/bindings/initial_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(290, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TryUnity WorkForce',
          initialBinding: InitialBinding(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: RoleBasedNavBar(userRole: 'Admin'),
        );
      },
    );
  }
}
