import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class LoaningScreen extends StatefulWidget {
  const LoaningScreen({super.key});

  @override
  _LoaningScreenState createState() => _LoaningScreenState();
}

class _LoaningScreenState extends State<LoaningScreen> {
  final _amountController = TextEditingController();

  void _applyLoan() {
    final accountService = Provider.of<AccountService>(context, listen: false);
    double amount = double.tryParse(_amountController.text) ?? 0;

    if (amount > 0) {
      accountService.loan(amount);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Loan of KSh $amount applied!')));
      _amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loaning')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Loan Amount'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _applyLoan,
              child: const Text('Apply for Loan'),
            ),
          ],
        ),
      ),
    );
  }
}
