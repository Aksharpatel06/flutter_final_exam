import 'package:firebase_auth/firebase_auth.dart';

class GoogleServices {
  static GoogleServices googleServices = GoogleServices._();
  GoogleServices._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String> createAccount(String email,String pwd)
  async {
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
}