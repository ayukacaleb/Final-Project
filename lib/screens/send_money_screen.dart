import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);
    final phoneController = TextEditingController();
    final amountController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void sendMoney() {
      if (formKey.currentState!.validate()) {
        double amount = double.parse(amountController.text);

        // Check if there's enough balance before sending money
        if (amount <= accountService.balance) {
          if (accountService.sendMoney(amount)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Money Sent Successfully! Your remaining balance is KSh ${accountService.balance.toStringAsFixed(2)}'),
              ),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to send money. Please try again.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Insufficient funds!')),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Recipient Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter recipient phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount (KSh)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendMoney,
                child: const Text('Send Money'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
