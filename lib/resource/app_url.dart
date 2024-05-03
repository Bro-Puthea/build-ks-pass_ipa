class AppUrl {
  static const url = "www.epass.eapp168.com";
  static const appUrl = "https://epass.eapp168.com/index.php/";
  static const apiVersion = 'api/v1/';
  static const baseUrl = "$appUrl$apiVersion";
  static const apiKey = "cscsk4kksccw8gwogsccosk0488gg40cc8844gcg";

  static const googleApiKey = "AIzaSyBuTB0T7hOZFnaVqt0g-TOA4wx4recDqxk";
  static const appId = "delivery";

  static const imagePath = "https://phumstore.eapp168.com/assets/uploads/";

  static const maxLimit = 300;
  static const inifinitLimit = 100;

  /// Min length of password
  static const minPasswordLength = 8;
  static const requiredSignInFirst = true;

// Notification OneSignal
  static const oneSignalAppId = 'b8e3436f-b9a6-485d-ab99-6829359857ff';

//pre-register
  static var preRegisterUrl = "${baseUrl}pre_registers";
  static var preRegisterPreviewUrl =
      "${baseUrl}pre_registers/details_pre_register/";
  static var addPreRegisterUrl = "${baseUrl}pre_registers/add";
  static var updatePreRegisterUrl =
      "${baseUrl}pre_registers/update_pre_register/";
  static var employeesUrl = "${baseUrl}employees";
  static var departmentUrl = "${baseUrl}departments";
  static var deleteRegisterUrl = "${baseUrl}pre_registers/delete_pre_register/";
  static var cancelRegisterUrl = "${baseUrl}pre_registers/cancel_pre_register/";
  static var vistorUrl = "${baseUrl}visitors";
  static var vistorPreviewUrl = "${baseUrl}visitors/details_visitor/";
  static var cardNoUrl = "${baseUrl}visitors/security_card";
  static var historyVisitorUrl = "${baseUrl}visitors/history_visitor";

  //dashboard
  static var dashboardUrl = "${baseUrl}visitors/dashboard";

  //auth
  static var loginUrl = "${baseUrl}auth/login";
  static var profileUrl = "${baseUrl}auth/profile_preview";
  static var changPasswordUrl = "${baseUrl}auth/change_password";
  static var updateProfileUrl = "${baseUrl}auth/update_profile";
  static var updateProfilePictureUrl = "${baseUrl}auth/change_profile_picture";

  //Visitor
  static var visitorCheckoutEndpoint = "visitors/scan_check_out";
  static var visitorCheckInEndpoint = "visitors/scan_check_in";
  static var beenHereBeforeEndpoint = "visitors/been_here_before";
  static var registerNewVistorUrl = "${baseUrl}visitors/add_visitor";
  static var allowedUrl = "${baseUrl}visitors/allow";
  static var getAllowedUrl = "${baseUrl}visitors/allowed_status/";
}
