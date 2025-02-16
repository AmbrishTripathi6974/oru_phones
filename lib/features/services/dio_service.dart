import 'dart:developer';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  static final DioService _instance = DioService._internal();
  late Dio dio;
  late PersistCookieJar cookieJar;
  bool _isUserLoggedIn = false;

  factory DioService() => _instance;

  DioService._internal() {
    dio = Dio(BaseOptions(
      baseUrl: "http://40.90.224.241:5000",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _initCookies();
  }

  /// 🔹 Initialize Cookie Storage and Check Login State
  Future<void> _initCookies() async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final cookiePath = "${appDocDir.path}/cookies";
      log("📂 Cookie Storage Path: $cookiePath");

      cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));
      dio.interceptors.add(CookieManager(cookieJar));

      // ✅ First, check user session from API
      _isUserLoggedIn = await checkUserSession();

      // ✅ If session check fails, fall back to stored user data
      if (!_isUserLoggedIn) {
        Map<String, String> userData = await loadUserData();
        if (userData["userName"]!.isNotEmpty) {
          _isUserLoggedIn = true;
        }
      }
    } catch (e) {
      log("❌ Error initializing cookies: $e");
    }
  }

  /// 🔹 Check if user is logged in based on session cookies
  Future<bool> checkUserSession() async {
    try {
      log("🔍 Checking user session...");
      final response = await dio.get("/isLoggedIn");

      bool loggedIn = response.data['isLoggedIn'] == true;
      log("✅ User session status: $loggedIn");

      if (loggedIn) {
        final user = response.data['user'];
        if (user != null) {
          await saveUserData(user);
        }
      }

      return loggedIn;
    } catch (e) {
      log("❌ Error checking session: $e");
      return false;
    }
  }

  /// 🔹 Save user data in cookies and SharedPreferences after login
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      // Save user data in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userData', jsonEncode(userData));

      // Save in cookies for API session
      List<Cookie> cookies = [
        Cookie('userName', userData['userName'] ?? ""),
        Cookie('createdDate', userData['createdDate'] ?? ""),
      ];

      await cookieJar.saveFromResponse(Uri.parse("http://40.90.224.241:5000"), cookies);
      log("✅ User data saved successfully!");
    } catch (e) {
      log("❌ Error saving user data: $e");
    }
  }

  /// 🔹 Public method to load user data (from SharedPreferences)
  Future<Map<String, String>> loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userDataString = prefs.getString('userData');

      if (userDataString != null) {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        return {
          "userName": userData['userName'] ?? "",
          "createdDate": userData['createdDate'] ?? "",
        };
      }
    } catch (e) {
      log("❌ Error loading user data: $e");
    }

    return {"userName": "", "createdDate": ""};
  }

  /// 🔹 Get current session cookies
  Future<List<Cookie>> getCookies() async {
    try {
      final cookies = await cookieJar.loadForRequest(Uri.parse("http://40.90.224.241:5000"));
      log("🍪 Retrieved Cookies: $cookies");
      return cookies;
    } catch (e) {
      log("❌ Error retrieving cookies: $e");
      return [];
    }
  }

  /// 🔹 Clear all session data (Logout)
  Future<void> clearSessionData() async {
    try {
      log("🗑️ Clearing session and user data...");

      // Clear cookies
      await cookieJar.delete(Uri.parse("http://40.90.224.241:5000"));

      // Clear user data from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('userData');

      _isUserLoggedIn = false;
      log("✅ Successfully logged out!");
    } catch (e) {
      log("❌ Error clearing session data: $e");
    }
  }

  /// 🔹 Getter for login status
  bool get isUserLoggedIn => _isUserLoggedIn;
}
