import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';

class PayBillsScreen extends StatefulWidget {
  const PayBillsScreen({super.key});

  @override
  _PayBillsScreenState createState() => _PayBillsScreenState();
}

class _PayBillsScreenState extends State<PayBillsScreen> {
  final _billTypeController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _payBills() {
    if (_formKey.currentState!.validate()) {
      double amount = double.parse(_amountController.text);
      final accountService = Provider.of<AccountService>(context, listen: false);

      if (accountService.payBills(amount)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bill Paid Successfully! Your remaining balance is KSh ${accountService.balance}')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Insufficient funds!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Bills')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _billTypeController,
                decoration: const InputDecoration(labelText: 'Bill Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter bill type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
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
                onPressed: _payBills,
                child: const Text('Pay Bill'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
