import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bankapp/modelController.dart';
import 'package:provider/provider.dart';
import 'addAccount.dart';
import 'addTransaction.dart';
import 'frontpage.dart';
import 'transactionPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => ModelController(),
    child: BankApp(),
  ));
}

class BankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Frontpage(),
      routes: {
        '/addAccount': (BuildContext context) => AddAccount(),
        '/transactionPage': (BuildContext context) => TransactionPage(),
        '/addTransaction': (BuildContext context) => AddTransaction(),
      },
    );
  }
}
