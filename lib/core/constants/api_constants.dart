class ApiConstants {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static const String logoutEndpoint = '/logout';
  static const String signInOfficeEndpoint = '/login';

  static String get logoutUrl => '$baseUrl$logoutEndpoint';
  static String get signInOfficeUrl => '$baseUrl$signInOfficeEndpoint';
}
