import 'package:flutter/foundation.dart';

class AccountService extends ChangeNotifier {
  double _balance = 0.0;
  double _annualContributions = 0.0; // Track total contributions annually
  double _pensionFund = 0.0; // Total pension fund
  double _dividends = 0.0; // Total dividends earned

  double get balance => _balance;
  double get annualContributions => _annualContributions;
  double get pensionFund => _pensionFund;
  double get dividends => _dividends;

  void deposit(double amount) {
    _balance += amount;
    _annualContributions += amount; // Add to annual contributions
    notifyListeners();
  }

  bool withdraw(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      notifyListeners();
      return true; // Indicate successful withdrawal
    }
    return false; // Indicate failure
  }

  double calculateDividends() {
    double dividend = _annualContributions * 0.08; // 8% of contributions
    _dividends += dividend; // Add to total dividends
    return dividend;
  }

  void loan(double amount) {
    if (_balance < 1000000 && amount <= 200000) {
      // School fee loan
      _balance += amount; // Assuming loan increases balance
      notifyListeners();
    } else if (_balance >= 1000000) {
      // Investment loan logic can be added here
      _balance += amount; // Assuming loan increases balance
      notifyListeners();
    }
  }

  void deductForPension() {
    double deduction = _annualContributions * 0.02; // 2% of contributions
    _pensionFund += deduction; // Add to pension fund
    notifyListeners();
  }

  bool buyAirtime(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      notifyListeners();
      return true; // Indicate successful airtime purchase
    }
    return false; // Indicate failure
  }

  bool payBills(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      notifyListeners();
      return true; // Indicate successful bill payment
    }
    return false; // Indicate failure
  }

  bool sendMoney(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
      notifyListeners();
      return true; // Indicate success
    }
    return false; // Indicate failure
  }

  void processEndOfYear() {
    deductForPension();
    calculateDividends(); // Optionally calculate dividends here too
  }
}
