import 'package:zidify_app/service_locator.dart';
import 'package:zidify_app/utils/constants/go_router.dart';
import 'package:flutter/material.dart';
// import 'features/auth/ui/sign_in.dart';
import 'utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Agakesi',
      themeMode: ThemeMode.system,
      theme: AGAppTheme.lightTheme,
      darkTheme: AGAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: AppGoRouter().router,
    );
  }
}
