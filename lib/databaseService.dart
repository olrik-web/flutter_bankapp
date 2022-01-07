import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'model.dart';

class DatabaseService {
  final firestore.FirebaseFirestore _db = firestore.FirebaseFirestore.instance;

  Stream<firestore.QuerySnapshot> accountStream() {
    return _db.collection('accounts').orderBy('name').snapshots();
  }

  add({Account account}) async {
    await _db.collection('accounts').add(account.toMap());
  }

  addTransaction({Account account, Transaction transaction}) {
    List<dynamic> transactions = [transaction.toMap()];
    firestore.DocumentReference instans =
        _db.collection('accounts').doc(account.id);
    instans.update(
        {'transactions': firestore.FieldValue.arrayUnion(transactions)});
  }
}
