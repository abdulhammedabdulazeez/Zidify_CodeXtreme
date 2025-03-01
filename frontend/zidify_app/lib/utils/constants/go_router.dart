import 'package:go_router/go_router.dart';
import 'package:zidify_app/features/auth/ui/sign_in.dart';
import 'package:zidify_app/features/auth/ui/sign_up.dart';
import 'package:zidify_app/features/home/errro_page.dart';

import 'package:zidify_app/utils/constants/texts.dart';


class AppGoRouter {
  // static GoRouter get router => _goRouter;

  GoRouter router = GoRouter(
    // navigatorKey: _rootNavigatorKey,
    // initialLocation: AppTexts.homeRoute,
    initialLocation: AppTexts.signupRoute,

    debugLogDiagnostics: true,
    routes: [
      // Sign In
      GoRoute(
        path: AppTexts.signinRoute,
        name: AppTexts.signinRouteName,
        builder: (context, state) => const SignInScreen(),
      ),
      // Sign Up
      GoRoute(
        path: AppTexts.signupRoute,
        name: AppTexts.signupRouteName,
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}
