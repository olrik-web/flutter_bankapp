import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context).settings.arguments as Map;
    var format = DateFormat('d. MMMM yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 80,
                color: Colors.lightBlue[200],
                child: Center(
                  child: Text(
                    argument['account'].name +
                        "\n" +
                        argument['account'].iban +
                        "\nkr. " +
                        argument['account'].totalAmount.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: argument['account'].transactions.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Transaction transaction =
                      argument['account'].transactions[index];
                  return Card(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${transaction.beneficiary}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("kr. ${transaction.amount}",
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      subtitle: Text(format.format(transaction.creationDate)),
                    ),
                  );
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/addTransaction',
                arguments: argument['account']);
          },
          icon: Icon(Icons.add),
          label: Text("New transaction")),
    );
  }
}
