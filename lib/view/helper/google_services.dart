import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleServices {
  static GoogleServices googleServices = GoogleServices._();

  GoogleServices._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> createAccount(String email, String pwd) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      return 'Success';
    } catch (e) {
      print(e);
      return 'failed';
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addToAllDataStoreToFirebase(Map<String, dynamic> data) {
    CollectionReference reference = firestore.collection('notes');
    reference.add(data);
  }

  Stream<QuerySnapshot> getData() {
    Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
        firestore.collection('notes').snapshots();
    return querySnapshot;
  }
}
