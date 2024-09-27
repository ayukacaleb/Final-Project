import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class PensionScreen extends StatelessWidget {
  const PensionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Pension')),
      body: Center(
        child: Text('Pension Fund: KSh ${accountService.pensionFund.toStringAsFixed(2)}'),
      ),
    );
  }
}
