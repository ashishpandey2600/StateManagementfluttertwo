import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:statemanagementtwo/screen/optionscreen.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late String email ;
 late  String password;

  bool showspinner = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OptionScreen()));
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.arrow_back_ios_new_sharp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 50),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text("Please sign in to continue."),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                      key: _formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onChanged: ( value) {
                                  email = value;
                                },
                                validator: (value) {
                                  return value == null ? 'Enter Email' : null;
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onChanged: (value) {
                                password = value;
                              },
                              validator: (value) {
                                if (value == null || value == value.isEmpty) {
                                  return ' please Enter password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  showspinner = true;
                                  setState(() {});

                                  try {
                                    final user =
                                        auth.signInWithEmailAndPassword(
                                            email: email.toString(),
                                            password: password.toString());
                                    if (user != null) {
                                      toastMessage("Succesfully login");
                                      setState(() {
                                        showspinner = false;
                                      });

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                    }
                                  } catch (e) {
                                    print(e.toString());
                                    toastMessage(e.toString());
                                    setState(() {
                                      showspinner = false;
                                    });
                                  }
                                }
                              },
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Login    ",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Icon(Icons.arrow_right_alt_outlined),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      )),
                )
              ]),
        ),
      ),
    );
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
