import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  // Method to clear SharedPreferences and log out
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all saved data in SharedPreferences
    print(await prefs.getKeys()); // This should print an empty set
  }
}
