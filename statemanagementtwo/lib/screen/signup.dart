import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  bool showspinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up")),
      body: Column(children: [
        Form(
          child: Column(children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              onChanged: (String value) {
                email = value;
              },
              validator: (value) {
                return value == null ? 'Enter Password' : null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Password',
                labelText: 'Password',
              ),
              onChanged: (String value) {
                password = value;
              },
              validator: (value) {
                return value == null ? 'Enter Password' : null;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  try {
                    final user = auth.createUserWithEmailAndPassword(
                        email: email.toString().trim(),
                        password: password.toString().trim());
                    if (user != null) {
                      print("sign u p successgul");
                      toastmessage("signup successful");
                    }
                  } catch (e) {
                    print(e.toString());
                    toastmessage(e.toString());
                  }
                },
                child: Text("Sign Up"))
          ]),
        )
      ]),
    );
  }

  void toastmessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
      fontSize: 16,
      timeInSecForIosWeb: 5,
    );
  }
}
