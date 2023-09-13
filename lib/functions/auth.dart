import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userauth/Pages/home.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      final user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'name': name,
        'email': email,
      });
      CircularProgressIndicator();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Successful')),

      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
      
    } 
    on FirebaseAuthException catch (e) {
    
  if (e.code == 'weak-password') {
    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('The password provided is too weak.')),
    );
  } else if (e.code == 'email-already-in-use') {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('The account already exists for that email.')),
    );

  }
} catch (e) {
  print(e);
}
return user;
  }


  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    //check if email and password are correct
    //if correct then go to home page
    //if not correct then show error in snackbar
    User? user;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      user = credential.user;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
    
     on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('No user found for that email')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Wrong password')),
        );
      }
    }
  }

  static Future<void> signOut() async {
    //signout from the app
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }
  
}


