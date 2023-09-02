// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_final_fields, non_constant_identifier_names, sized_box_for_whitespace, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/screens/auth/SignUp.dart';
import 'package:flutter_application_1/screens/auth/login.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/util/toast.dart';

class EmailSignUp extends StatefulWidget {
  const EmailSignUp({super.key});

  @override
  State<EmailSignUp> createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _PasswordController.dispose();
    super.dispose();
  }

  void signup() async {
    String res = await AuthProvider().signUpUser(
        email: _emailController.text, password: _PasswordController.text);
    if (res == "success") {
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    } else {
      Toast.show(res, context);
      print(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("RYTHYM",
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(19, 129, 153, 1))),
                    const Text("MULTIFY",
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(19, 129, 153, 1))),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 241, 241, 241),
                            contentPadding: EdgeInsets.all(16),
                            hintText: "Email",
                            hintStyle:
                                TextStyle(color: Color.fromARGB(97, 0, 0, 0)),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: TextField(
                        controller: _PasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 241, 241, 241),
                            contentPadding: EdgeInsets.all(16),
                            hintText: "Password",
                            hintStyle:
                                TextStyle(color: Color.fromARGB(97, 0, 0, 0)),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)))),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signup();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 20, 157, 141),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set the border radius
                        ),
                        fixedSize: Size(MediaQuery.of(context).size.width * 0.7,
                            50), // Set the width and height
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  color: Color.fromRGBO(20, 156, 140, 1)),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            icon: Icon(Icons.phone, size: 50)),
                      ],
                    ),
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                  ],
                ))));
  }
}
