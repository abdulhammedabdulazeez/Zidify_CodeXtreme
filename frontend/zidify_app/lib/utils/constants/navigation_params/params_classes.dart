abstract class NavigationParams {
  const NavigationParams();

  // Every navigation parameter class must implement toJson
  Map<String, dynamic> toJson();
}
