import 'package:flutter/material.dart';

class WalletProvider with ChangeNotifier {
  double _balance = 789.00;
  double _amountDue = 189.00;

  final List<Map<String, dynamic>> _transactions = [
    {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#01234",
      "desc": "Delivery earnings",
      "time": "2 hours ago",
      "amount": "+₹8.50",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.account_balance,
      "title": "Bank Transfer",
      "id": "",
      "desc": "Withdrawn to Bank ****4532",
      "time": "Yesterday",
      "amount": "₹150.00",
      "isPositive": false,
      "isWithdrawal": true,
      "type": "Debit",
    },
    {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#01189",
      "desc": "Delivery earnings",
      "time": "Yesterday",
      "amount": "+₹12.30",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.local_gas_station,
      "title": "Fuel Expense",
      "id": "",
      "desc": "Gasoline purchase",
      "time": "2 days ago",
      "amount": "₹25.00",
      "isPositive": false,
      "isWithdrawal": true,
      "customIconBg": const Color(0xFFFFEBEE),
      "customIconColor": Colors.red,
      "type": "Debit",
    },
    {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#00987",
      "desc": "Delivery earnings",
      "time": "2 days ago",
      "amount": "+₹15.75",
      "isPositive": true,
      "type": "Credit",
    },
    {
      "icon": Icons.trending_up,
      "title": "Weekly Bonus",
      "id": "",
      "desc": "Performance bonus",
      "time": "3 days ago",
      "amount": "+₹50.00",
      "isPositive": true,
      "customIconBg": const Color(0xFFFFF3E0),
      "customIconColor": Colors.orange,
      "type": "Credit",
    },
    {
      "icon": Icons.shopping_bag_outlined,
      "title": "Equipment Buy",
      "id": "",
      "desc": "Delivery bag purchase",
      "time": "4 days ago",
      "amount": "₹45.00",
      "isPositive": false,
      "isWithdrawal": true,
      "type": "Debit",
    },
     {
      "icon": Icons.trending_up,
      "title": "Order Delivery",
      "id": "#00852",
      "desc": "Delivery earnings",
      "time": "5 days ago",
      "amount": "+₹9.20",
      "isPositive": true,
      "type": "Credit",
    },
  ];

  double get balance => _balance;
  double get amountDue => _amountDue;
  List<Map<String, dynamic>> get transactions => _transactions;

  void addMoney(double amount) {
    if (amount <= 0) return;
    _balance += amount;
    _transactions.insert(0, {
      "icon": Icons.account_balance_wallet,
      "title": "Money Added",
      "id": "",
      "desc": "Wallet top-up",
      "time": "Just now",
      "amount": "+₹${amount.toStringAsFixed(2)}",
      "isPositive": true,
      "type": "Credit",
    });
    notifyListeners();
  }

  void withdrawMoney(double amount) {
    if (amount <= 0 || amount > _balance) return;
    _balance -= amount;
    _transactions.insert(0, {
      "icon": Icons.account_balance,
      "title": "Withdrawal",
      "id": "",
      "desc": "Transfer to bank",
      "time": "Just now",
      "amount": "₹${amount.toStringAsFixed(2)}",
      "isPositive": false,
      "isWithdrawal": true,
      "type": "Debit",
    });
    notifyListeners();
  }

  void settlePayment(double amount) {
    if (amount <= 0 || amount > _balance || amount > _amountDue) return;
    _balance -= amount;
    _amountDue -= amount;
    _transactions.insert(0, {
      "icon": Icons.payment,
      "title": "Dues Settled",
      "id": "",
      "desc": "Platform fee payment",
      "time": "Just now",
      "amount": "₹${amount.toStringAsFixed(2)}",
      "isPositive": false,
      "isWithdrawal": true,
      "customIconBg": const Color(0xFFFFEBEE),
      "customIconColor": Colors.red,
      "type": "Debit",
    });
    notifyListeners();
  }
}
