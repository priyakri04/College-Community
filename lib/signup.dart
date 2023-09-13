import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userauth/functions/auth.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    String email = "", password = "", name = "";
    bool login = false;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: const Text('SignUp Page')),
        backgroundColor: Colors.blueGrey,
      ),
      body:
      //background image
       Form(
        key: form,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                  key: ValueKey('email'),
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    email = value!;
                  }),
              SizedBox(height: 10),
              TextFormField(
                key: ValueKey('password'),
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Please enter password with 6 or more characters';
                  }
                  return null;
                },
                obscureText: true,
                onSaved: (value) => password = password!,
              ),
              //create login button just under the password input field
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(10), //padding for the button
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (form.currentState!.validate()) {
                          form.currentState!.save();
                          try {
                            await FireAuth.registerUsingEmailPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim(),
                              context: context
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      child: const Text('Register'),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}