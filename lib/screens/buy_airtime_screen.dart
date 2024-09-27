import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class BuyAirtimeScreen extends StatelessWidget {
  const BuyAirtimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);
    final phoneController = TextEditingController();
    final amountController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void buyAirtime() {
      if (formKey.currentState!.validate()) {
        double amount = double.parse(amountController.text);
        if (accountService.buyAirtime(amount)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Airtime Purchased Successfully! Your remaining balance is KSh ${accountService.balance}')));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Insufficient funds!')));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Buy Airtime')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
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
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: buyAirtime,
                child: const Text('Buy Airtime'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
