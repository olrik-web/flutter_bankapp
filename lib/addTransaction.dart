import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bankapp/model.dart';
import 'package:provider/provider.dart';
import 'modelController.dart';

class AddTransaction extends StatefulWidget {
  AddTransaction({Key key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _formKey = GlobalKey<FormState>();
  Transaction _transaction = Transaction();

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context).settings.arguments as Account;

    return Scaffold(
      appBar: AppBar(
        title: Text("New Transaction"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (!isNumeric(value, argument)) {
                    return 'Please enter a correct amount.';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Amount'),
                onSaved: (amount) {
                  setState(() {
                    _transaction.amount = double.parse(amount);
                  });
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a beneficiary.';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Beneficiary'),
                onSaved: (beneficiary) {
                  setState(() {
                    _transaction.beneficiary = beneficiary;
                  });
                },
              ),
              Container(
                width: double.infinity,
                child: DateTimePicker(
                  type: DateTimePickerType.dateTime,
                  dateMask: 'd MMMM, yyyy - HH:mm',
                  initialValue: DateTime.now().toString(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date and time',
                  onSaved: (date) {
                    setState(() {
                      _transaction.creationDate = DateTime.parse(date);
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final _form = _formKey.currentState;
                    _form.save();
                    Provider.of<ModelController>(context, listen: false)
                        .addTransaction(
                            transaction: _transaction, account: argument);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isNumeric(String string, Account account) {
  if (string == null || string.isEmpty) {
    return false;
  }

  final number = double.tryParse(string);
  if (number == null) {
    return false;
  }
  if (account.totalAmount - (-number) < 0) {
    return false;
  }
  return true;
}
