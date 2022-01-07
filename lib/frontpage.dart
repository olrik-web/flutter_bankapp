import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'modelController.dart';

class Frontpage extends StatelessWidget {
  const Frontpage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: Consumer<ModelController>(
          builder: (context, _modelController, widgets) {
        return ListView.builder(
            itemCount: _modelController.numberOfAccounts,
            itemBuilder: (context, index) {
              Account account = _modelController.getAccount(index);
              return Card(
                child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${account.name}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "kr. ${account.totalAmount}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: Text("${account.kind}\n${account.iban}"),
                    onTap: () {
                      Navigator.pushNamed(context, '/transactionPage',
                          arguments: {'account': account});
                    }),
              );
            });
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addAccount');
        },
        icon: Icon(Icons.add),
        label: Text("New account"),
      ),
    );
  }
}
