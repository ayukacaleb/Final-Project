import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);
    final TextEditingController amountController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    void withdraw() {
      if (formKey.currentState!.validate()) {
        double amount = double.parse(amountController.text);
        if (accountService.withdraw(amount)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Withdrawal Successful! Your remaining balance is KSh ${accountService.balance}')));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Insufficient funds!')));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Withdraw Money')),
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
                  double? parsedValue = double.tryParse(value);
                  if (parsedValue == null || parsedValue <= 0) {
                    return 'Please enter a valid positive amount';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: withdraw,
                child: const Text('Withdraw'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
