import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String name;
  String iban;
  String kind;
  String id;
  List<Transaction> transactions = [];
  double totalAmount = 0;

  Account(
      {this.name,
      this.iban,
      this.kind,
      this.transactions,
      this.totalAmount,
      this.id});

  factory Account.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data();
    List<Transaction> transactionList = [];
    String docId = doc.id;
    double saldo = 0;
    if (data['transactions'] != null) {
      for (int i = 0; i < data['transactions'].length; i++) {
        Transaction transaction = Transaction.fromMap(data['transactions'][i]);
        transactionList.add(transaction);
      }
      Transaction tr = transactionList.reduce(
          (firstTransaction, secondTransaction) => Transaction(
              amount: firstTransaction.amount + secondTransaction.amount));
      saldo = tr.amount;
    }

    Account _account = Account(
      name: data['name'],
      iban: data['iban'],
      kind: data['kind'],
      transactions: transactionList,
      totalAmount: saldo,
      id: docId,
    );

    return _account;
  }

  toMap() {
    return {
      'name': this.name,
      'iban': this.iban,
      'kind': this.kind,
      'transactions': this.transactions
    };
  }
}

class Transaction {
  double amount;
  DateTime creationDate;
  String beneficiary;

  Transaction({this.amount, this.creationDate, this.beneficiary});

  factory Transaction.fromMap(Map<String, dynamic> data) {
    Timestamp t = data['date'];
    num n = data['amount'];
    Transaction _transaction = Transaction(beneficiary: data['beneficiary']);
    _transaction.amount = n.toDouble();
    _transaction.creationDate = t.toDate();
    return _transaction;
  }

  toMap() {
    return {
      'amount': this.amount,
      'date': this.creationDate,
      'beneficiary': this.beneficiary
    };
  }
}
