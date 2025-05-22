import 'package:shared_preferences/shared_preferences.dart';

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
  }

  bool get isLoggedIn => token != null;
}
