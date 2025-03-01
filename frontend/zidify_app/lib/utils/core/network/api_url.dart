class ApiUrls {
  static const baseURL = 'https://agakesi-api.onrender.com/api/';
  static const signup = '${baseURL}auth/signup';
  static const login = '${baseURL}auth/login';
  static const getUser = '${baseURL}users/me';
  static const forgotPassword = '${baseURL}auth/forgot-pswd';
  static const refreshToken = '${baseURL}auth/refresh-token';

  // SaveBox
  static const saveBoxInfo = '${baseURL}users/savebox';
  static const fundingSources = '${baseURL}funding-sources';
  static const fundDestinations = '${baseURL}fund-destionations';
  static String deposit(String userId) => '${baseURL}saveboxes/$userId/deposit';
  static String withdraw(String userId) =>
      '${baseURL}saveboxes/$userId/withdraw';
}
