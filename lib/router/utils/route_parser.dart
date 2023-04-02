extension RouteParser on String {
  Uri get parseUri => Uri.parse(this);

  String get basePath =>
      parseUri.pathSegments.isNotEmpty ? parseUri.pathSegments.first : '/';
  List<String> get pathSegments => parseUri.pathSegments;
  Map<String, String> get queryParamaters => parseUri.queryParameters;
}
