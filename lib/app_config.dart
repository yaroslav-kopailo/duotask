class AppConfig {
  AppConfig({
    required String apiHost,
  }) : _apiHost = apiHost;

  final String _apiHost;

  String get ipDataApi => 'http://$_apiHost';
}
