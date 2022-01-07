import 'package:flutter/material.dart';
import 'databaseService.dart';
import 'model.dart';

class ModelController extends ChangeNotifier {
  List<Account> _accounts = [];

  final DatabaseService _dbService = DatabaseService();

  ModelController() {
    _dbService.accountStream().listen((snapshot) {
      _accounts.clear();
      snapshot.docs.forEach((account) {
        _accounts.add(Account.fromFirestore(account));
      });
      notifyListeners();
    });
  }
  int get numberOfAccounts {
    return _accounts.length ?? 0;
  }

  Account getAccount(int index) {
    return _accounts[index];
  }

  add({Account account}) {
    _accounts.add(account);
    _dbService.add(account: account);
    notifyListeners();
  }

  addTransaction({Transaction transaction, Account account}) {
    account.transactions.add(transaction);
    _dbService.addTransaction(transaction: transaction, account: account);
    notifyListeners();
  }
}
