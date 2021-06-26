import 'package:cloud_firestore/cloud_firestore.dart';

class CloudOperations {
  ///create a new instance in firebase NO-SQL Cloud
  static Future<void> addToCloud({String serverPath,data}) async {
    await FirebaseFirestore.instance.doc('$serverPath').set(data);
  }
}
