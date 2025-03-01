import 'package:zidify_app/utils/constants/navigation_params/nav_params_coded.dart';
import 'package:zidify_app/utils/constants/navigation_params/params_classes.dart';
import 'package:go_router/go_router.dart';

class RouteHelpers {
  /// Gets typed navigation parameters from the route state
  ///
  /// Type parameter T must extend NavigationParams to ensure type safety
  /// Returns the correctly typed parameter object or throws an exception if
  /// parameters are missing or invalid
  static T getTypedParams<T extends NavigationParams>(
    GoRouterState state,
    String screenName,
  ) {
    // First, safely extract the JSON extra data
    final jsonExtra = state.extra as Map<String, dynamic>?;

    // Use our codec to convert JSON back to a NavigationParams object
    final params = NavigationParamsCodec.fromJson(jsonExtra);

    // Verify we got the correct type of parameters
    if (params == null) {
      throw Exception('Missing required parameters for $screenName');
    }

    if (params is! T) {
      throw Exception('Invalid parameter type for $screenName. '
          'Expected ${T.toString()}, but got ${params.runtimeType}');
    }

    return params;
  }
}
