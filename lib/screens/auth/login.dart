// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names, prefer_final_fields, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/screens/auth/SignUp.dart';
import 'package:flutter_application_1/screens/auth/email_signup.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/util/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _PasswordController.dispose();
    super.dispose();
  }

  void login() async {
    String res = await AuthProvider().signInUser(
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                        keyboardType: TextInputType.emailAddress,
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
                        login();
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
                        "LOGIN",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Dont have a account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmailSignUp()));
                            },
                            child: Text(
                              "Sign Up",
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
                          icon: const Icon(
                            Icons.phone,
                            size: 50,
                          ),
                        )
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
