// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, use_build_context_synchronously, unused_local_variable

import 'package:barber_app/pages/home.dart';
import 'package:barber_app/pages/login.dart';
import 'package:barber_app/services/database.dart';
import 'package:barber_app/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? password, mail, name;
  TextEditingController nameController = new TextEditingController();
  TextEditingController gmailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && mail != null && name != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
        String id = randomAlphaNumeric(10);
        await SharedpreferenceHelper().saveUserName(nameController.text);
        await SharedpreferenceHelper().saveUserEmail(gmailController.text);
        await SharedpreferenceHelper().saveUserId(id);
        await SharedpreferenceHelper().saveUserImage(
            "https://i.pravatar.cc/250?u=mail@ashallendesign.co.uk");

        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": gmailController.text,
          "Id": id,
          "Image": "https://i.pravatar.cc/250?u=mail@ashallendesign.co.uk"
        };
        await DatabaseMethod().addUserDetails(userInfoMap, id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registration Successfully",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Weak Password",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Account Already Exists",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50.0, left: 25.0),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFb91635),
                    Color(0xFF621d3c),
                    Color(0xFF311937),
                  ],
                ),
              ),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 4,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          color: Color(0xFFb91635),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "PLEASE ENTER NAME";
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: 'Name',
                            suffixIcon: Icon(Icons.person_outline)),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        'Gmail',
                        style: TextStyle(
                          color: Color(0xFFb91635),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "PLEASE ENTER GMAIL";
                          }
                          return null;
                        },
                        controller: gmailController,
                        decoration: InputDecoration(
                            hintText: 'Gmail',
                            suffixIcon: Icon(Icons.mail_outline)),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Color(0xFFb91635),
                          fontSize: 23.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "PLEASE ENTER PASSWORD";
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: Icon(Icons.password_outlined),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFb91635),
                              Color(0xFF621d3c),
                              Color(0xFF311937),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                setState(
                                  () {
                                    mail = gmailController.text;
                                    name = nameController.text;
                                    password = passwordController.text;
                                  },
                                );
                              }
                              registration();
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 65,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Color(0xFF311937),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                color: Color(0xFF621d3c),
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
