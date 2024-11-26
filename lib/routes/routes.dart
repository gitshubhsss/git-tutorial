// lib/routes/app_routes.dart
import 'package:firebase_connection/views/homePage.dart';
import 'package:firebase_connection/views/profilePage.dart';
import 'package:firebase_connection/views/updateProfilepage.dart';
import 'package:get/get.dart';
import 'package:firebase_connection/auth/Login_page.dart';
import 'package:firebase_connection/auth/SignUp_page.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/signup', page: () => const SignupPage()),
    GetPage(name: '/home', page: () => const Homepage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
    GetPage(name: '/updateProfile', page: () => const UpdateProfilePage()),
    // Add more routes as needed
  ];
}
