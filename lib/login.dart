//login page ui with email and password input fields and a login button
//firebase authentication is not implemented yet

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userauth/functions/auth.dart';
import 'package:userauth/Pages/home.dart';
import 'package:userauth/signup.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final form = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    String email = "", password = "";
    return Scaffold(
        appBar: AppBar(
          title:  Center(child: Text('Login Page')),
          backgroundColor: Colors.blueGrey,
        ),
        body: Form(
          key: form,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //take email as input in email variable using TextField widget
                    //and assign it to email variable
                    TextFormField(
                      key: ValueKey('email'),
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      onSaved: (newValue) => email = emailController.text!,
                    ),

                    SizedBox(height: 10),
                    TextFormField(
                      key: ValueKey('password'),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      onSaved: (newValue) =>
                          password = passwordController.text!,
                    ),
                    //call login() from login_button.dart
                    //pass email and password as parameters
                    //assign email and password to email and password variables
                    SizedBox(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(10), //padding for the button
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              FireAuth.signInUsingEmailPassword(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  context: context);
                                  
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),

        //create a signup button at the bottom of the screen

        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: const Text('Sign Up'),
              )
            ],
          ),
        ));
  }
}
