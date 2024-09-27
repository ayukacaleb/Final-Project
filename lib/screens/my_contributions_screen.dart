import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class MyContributionsScreen extends StatelessWidget {
  const MyContributionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Contributions')),
      body: Center(
        child: Text('Total Annual Contributions: KSh ${accountService.annualContributions.toStringAsFixed(2)}'),
      ),
    );
  }
}
