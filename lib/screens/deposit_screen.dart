import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);
    final amountController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void deposit() {
      if (formKey.currentState!.validate()) {
        double amount = double.parse(amountController.text);
        accountService.deposit(amount);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deposit Successful! Your new balance is KSh ${accountService.balance}')));
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Deposit Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount (KSh)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: deposit,
                child: const Text('Deposit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
