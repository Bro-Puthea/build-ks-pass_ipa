import 'package:igt_e_pass_app/data/model/user_login_model.dart';
import 'package:igt_e_pass_app/resource/constant.dart';
import 'package:igt_e_pass_app/utils/preference_helper.dart';

Future<String> getLangCode() async {
  return PrefsHelper.getString(Const.lang) ?? 'en';
}

Future<void> setLangCode(String langCode) async {
  await PrefsHelper.setString(Const.lang, langCode);
}

Future<bool> hasAccessToken() async {
  return await getAccessToken() != 'null';
}

Future<String> getAccessToken() async {
  return PrefsHelper.getString(Const.authentiated) ?? '';
}

Future<String> getUserId() async {
  return PrefsHelper.getString(Const.userId) ?? '';
}

Future<String> getGroupId() async {
  return PrefsHelper.getString(Const.groupId) ?? '';
}

Future<String> getGroupName() async {
  return PrefsHelper.getString(Const.groupName) ?? '';
}

Future<String> getPlayerId() async {
  return PrefsHelper.getString(Const.playerId) ?? '';
}

Future<void> setAccessToken(String accessToken) async {
  await PrefsHelper.setString(Const.authentiated, accessToken);
}

Future<void> setCustomerId(String customerId) async {
  await PrefsHelper.setString(Const.userId, customerId);
}

Future<void> setGroupId(String groupId) async {
  await PrefsHelper.setString(Const.groupId, groupId);
}

Future<void> setGroupName(String groupId) async {
  await PrefsHelper.setString(Const.groupName, groupId);
}

Future<void> setPlayerId(String playerId) async {
  await PrefsHelper.setString(Const.playerId, playerId);
}

Future<void> setUserInfo(User profileParam) async {
  await PrefsHelper.setString(Const.firstName, profileParam.firstName ?? '');
  await PrefsHelper.setString(Const.lastName, profileParam.lastName ?? '');
  await PrefsHelper.setString(Const.gener, profileParam.gender ?? '');
  await PrefsHelper.setString(Const.phone, profileParam.phone ?? '');
  await PrefsHelper.setString(Const.email, profileParam.email ?? 'N/A');
  await PrefsHelper.setString(Const.avatar, profileParam.imageUrl ?? '');
  await PrefsHelper.setString(Const.userName, profileParam.username ?? '');
  await PrefsHelper.setString(Const.address, profileParam.address ?? '');
  await PrefsHelper.setString(Const.userId, profileParam.id ?? '');
}

Future<void> setIsLogin(bool value) async {
  PrefsHelper.setBool(Const.isLogin, value);
}

Future<bool> getIsLogin() async {
  final value = await PrefsHelper.getValue(Const.isLogin, defaultValue: false);
  return value;
}

Future<void> clearUserData() async {
  final pref = await PrefsHelper.init();
  // await pref.remove(Const.firstName);
  // await pref.remove(Const.lastName);
  // await pref.remove(Const.gener);
  // await pref.remove(Const.phone);
  // await pref.remove(Const.email);
  // await pref.remove(Const.avatar);
  // await pref.remove(Const.userId);
  pref.clear();
  await setIsLogin(false);
}

Future<User> getUserInfo() async {
  final pref = await PrefsHelper.init();

  final fistName = pref.getString(Const.firstName);
  final lastName = pref.getString(Const.lastName);
  final gender = pref.getString(Const.gener);
  final phone = pref.getString(Const.phone);
  final email = pref.getString(Const.email);
  final avatar = pref.getString(Const.avatar);
  final userName = pref.getString(Const.userName);
  final address = pref.getString(Const.address);
  final userId = pref.getString(Const.userId);

  return User(
      firstName: fistName,
      lastName: lastName,
      gender: gender,
      phone: phone,
      email: email,
      imageUrl: avatar,
      username: userName,
      id: userId,
      address: address);
}
