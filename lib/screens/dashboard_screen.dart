import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/account_service.dart';
import 'login_screen.dart';
import 'pension_screen.dart';
import 'loaning_screen.dart';
import 'dividends_screen.dart';
import 'my_contributions_screen.dart';
import 'buy_airtime_screen.dart';
import 'withdraw_screen.dart';
import 'send_money_screen.dart';
import 'pay_bills_screen.dart';
import 'deposit_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display account balance at the top
            Text(
              'Account Balance: KSh ${accountService.balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Buttons for deposit, send money, pay bills, and buy airtime
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true, // Make grid view take only the necessary space
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling
              children: [
                _buildCard(context, 'Deposit', Icons.add, DepositScreen()),
                _buildCard(context, 'Pension', Icons.account_balance, PensionScreen()),
                _buildCard(context, 'Dividends', Icons.assessment, DividendsScreen()),
                _buildCard(context, 'Withdraw', Icons.remove, WithdrawScreen()),
                _buildCard(context, 'Loaning', Icons.money, LoaningScreen()),
                _buildCard(context, 'Send Money', Icons.send, SendMoneyScreen()),
                _buildCard(context, 'Pay Bills', Icons.payment, PayBillsScreen()),
                _buildCard(context, 'My Contributions', Icons.account_balance, MyContributionsScreen()),
                _buildCard(context, 'Buy Airtime', Icons.phone, BuyAirtimeScreen()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card _buildCard(BuildContext context, String title, IconData icon, Widget screen) {
    return Card(
      color: Colors.red[700], // Coke red
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
