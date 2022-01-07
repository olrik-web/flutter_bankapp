import 'package:flutter/material.dart';
import 'package:flutter_bankapp/model.dart';
import 'package:provider/provider.dart';
import 'modelController.dart';

class AddAccount extends StatefulWidget {
  AddAccount({Key key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final _formKey = GlobalKey<FormState>();
  Account _account = Account();

  static List<String> _kinds = [
    "Savings",
    "Checking",
    "Investment",
    "Household",
    "Transport",
    "Food",
    "Vacation",
    "Fixed Costs",
    "Miscellaneous"
  ];
  String dropdownValue = _kinds[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Account'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter IBAN number.';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'IBAN'),
                onSaved: (iban) {
                  setState(() {
                    _account.iban = iban;
                  });
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name.';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (name) {
                  setState(() {
                    _account.name = name;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                onSaved: (kind) {
                  setState(() {
                    _account.kind = kind;
                  });
                },
                items: _kinds.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final _form = _formKey.currentState;
                    _form.save();
                    Provider.of<ModelController>(context, listen: false)
                        .add(account: _account);
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
