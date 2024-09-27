import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  final List<User> _users = [];

  String? register(String username, String password) {
    if (_users.any((user) => user.username == username)) {
      return 'Username already exists';
    }
    _users.add(User(username: username, password: password));
    notifyListeners(); // Notify listeners if needed
    return null; // No error
  }

  String? login(String username, String password) {
    if (_users.any((user) => user.username == username && user.password == password)) {
      return null; // Login successful
    }
    return 'Invalid username or password';
  }
}
