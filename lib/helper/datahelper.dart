import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataHelper {
  DataHelper._();

  static final DataHelper dataHelper = DataHelper._();

  late SharedPreferences preferences;

  Future<Map?> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  final db = FirebaseFirestore.instance;

  setdata({
    required String userId,
  }) async {
    preferences.setString("userId", userId);
  }

  getsetdata() {
    String userId = preferences.getString("userId") ?? '';
    log(userId);
    return userId;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    // setdata(userId: '');
    preferences.remove("userId");

    await GoogleSignIn().signOut(); //For GoogleSignIn
    await FirebaseAuth.instance.signOut();
  }

  signInWithEmailAndPassword({
    required String email,
    required String pass,
  }) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      // return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  getdata(){
    return db.collection("product").snapshots();
  }

  getpromocode(){
    return db.collection("promocode").get();
  }

  upddata(){

  }
  addTodo({
    required String id,
    required String name,
    required double price,
    required String des,
    required String category,
    required String image,
    required String rating,
    required int count,
  }) async {
    final city = <String, dynamic>{
      "name": name,
      "price": price,
      "des": des,
      "category": category,
      "image": image,
      "rating": rating,
      "count": count,
    };

    await db
        .collection("product").doc(id).set(city)
        .onError((e, _) => print("Error writing document: $e"));
  }


  updproduct({
    required String id,
    required int count,
  }) async {
    final city = <String, dynamic>{
      "count": count,
    };

    await db
        .collection("product").doc(id).update(city).onError((e, _) => print("Error writing document: $e"));
  }

  updpromo({
    required String id,
    required int count,
  }) async {
    final city = <String, dynamic>{
      "qty": count,
    };

    await db
        .collection("promocode").doc(id).update(city).onError((e, _) => print("Error writing document: $e"));
  }

  // upd

  createUserWithEmailAndPassword(
      {required String email, required String pass}) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      // return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
    }
  }
}
