import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/account_service.dart';
import 'services/auth_service.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountService()),
        ChangeNotifierProvider(create: (context) => AuthService()), // AuthService now extends ChangeNotifier
      ],
      child: MaterialApp(
        title: 'Pioneer SACCO',
        theme: ThemeData(
          primarySwatch: Colors.red,
          appBarTheme: AppBarTheme(color: Colors.red[700]),
        ),
        home: LoginScreen(), // Start with the login screen
      ),
    );
  }
}
