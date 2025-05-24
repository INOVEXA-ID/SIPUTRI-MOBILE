import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siputri_mobile/core/helper/user_model.dart';

class TokenStorage {
  static final TokenStorage _instance = TokenStorage._internal();

  factory TokenStorage() {
    return _instance;
  }

  TokenStorage._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? get token => _prefs?.getString('token');

  Future<void> saveToken(String token) async {
    await _prefs?.setString('token', token);
  }

  Future<void> clearToken() async {
    await _prefs?.remove('token');
    await _prefs?.remove('user');
  }

  bool get isLoggedIn => token != null;
  Future<void> saveUser(User user) async {
    final userJson = jsonEncode(user.toJson());
    await _prefs?.setString('user', userJson);
  }

  User? get user {
    final userStr = _prefs?.getString('user');
    if (userStr == null) return null;
    return User.fromJson(jsonDecode(userStr));
  }
}
