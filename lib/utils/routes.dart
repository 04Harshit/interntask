import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/task_screen.dart';

class Routes {
  Map<String, Widget Function(BuildContext)> allRoutes = {
    '/': (context) => const HomeScreen(),
    '/register': (context) => const RegisterScreen(),
    '/login': (context) => const LoginScreen(),
    '/tasks': (context) => const TaskScreen(),
  };
}