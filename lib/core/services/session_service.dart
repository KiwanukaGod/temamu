import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  SessionService._();

  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserName = 'userName';
  static const String _keyUserPhone = 'userPhone';
  static const String _keyLastLogin = 'lastLoginTimestamp';
  static const Duration _sessionLifetime = Duration(days: 30);

  static Future<void> saveUserProfile({
    required String name,
    required String phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name.trim());
    await prefs.setString(_keyUserPhone, phone);
  }

  static Future<void> saveUserSession({
    String? name,
    required String phone,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final trimmedName = name?.trim();
    final currentDisplayName = Firebase.apps.isNotEmpty
        ? FirebaseAuth.instance.currentUser?.displayName
        : null;
    final preservedName =
        prefs.getString(_keyUserName) ?? currentDisplayName ?? 'User';
    final userName = (trimmedName == null || trimmedName.isEmpty)
        ? preservedName
        : trimmedName;

    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserName, userName);
    await prefs.setString(_keyUserPhone, phone);
    await prefs.setInt(_keyLastLogin, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<bool> isSessionValid() async {
    final prefs = await SharedPreferences.getInstance();
    final currentUser = Firebase.apps.isNotEmpty
        ? FirebaseAuth.instance.currentUser
        : null;

    if (currentUser != null) {
      await saveUserSession(
        name: prefs.getString(_keyUserName),
        phone: currentUser.phoneNumber ?? prefs.getString(_keyUserPhone) ?? '',
      );
      return true;
    }

    final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
    final lastLogin = prefs.getInt(_keyLastLogin);
    if (!isLoggedIn || lastLogin == null) {
      return false;
    }

    final duration = DateTime.now().difference(
      DateTime.fromMillisecondsSinceEpoch(lastLogin),
    );
    if (duration > _sessionLifetime) {
      await clearActiveSession();
      return false;
    }

    return true;
  }

  static Future<bool> hasStoredProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(_keyUserName)?.trim() ?? '';
    final phone = prefs.getString(_keyUserPhone)?.trim() ?? '';
    return name.isNotEmpty && phone.isNotEmpty;
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName) ?? 'User';
  }

  static Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString(_keyUserPhone)?.trim();
    if (phone == null || phone.isEmpty) {
      return null;
    }
    return phone;
  }

  static Future<void> clearActiveSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyLastLogin);
  }

  static Future<void> clearLocalSession() async {
    final prefs = await SharedPreferences.getInstance();
    await clearActiveSession();
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserPhone);
  }

  static Future<void> logout({bool clearProfile = false}) async {
    if (Firebase.apps.isNotEmpty) {
      await FirebaseAuth.instance.signOut();
    }
    if (clearProfile) {
      await clearLocalSession();
      return;
    }
    await clearActiveSession();
  }
}
