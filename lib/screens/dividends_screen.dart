import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class DividendsScreen extends StatelessWidget {
  const DividendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);
    double dividends = accountService.calculateDividends(); // Calculate dividends

    return Scaffold(
      appBar: AppBar(title: const Text('Dividends')),
      body: Center(
        child: Text('Total Dividends Earned: KSh ${accountService.dividends.toStringAsFixed(2)}'),
      ),
    );
  }
}
