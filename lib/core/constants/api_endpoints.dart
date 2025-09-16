class ApiEndpoints {
  // Base URL from environment
  static String get baseURL => 'https://up-dev-v2-api.adminurban.com/';
  static String get mobileApiPath => 'api/v2/mobile/';
  // Auth endpoints
  static String get checkPhoneExist =>
      "${baseURL + mobileApiPath}checkPhoneExist";
  static String get login => "${baseURL + mobileApiPath}signIn";
  static String get signup => "${baseURL + mobileApiPath}signup";
  static String get forgotPassword =>
      "${baseURL + mobileApiPath}forgotPassword";
}
