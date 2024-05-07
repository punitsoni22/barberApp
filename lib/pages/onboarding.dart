// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: Container(
        margin: EdgeInsets.only(top: 120.0),
        child: Column(
          children: [
            Image.asset("images/barber.png"),
            SizedBox(height: 50.0),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/home",
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                    color: Color(0xFFdf711a),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Text(
                  "Get a Stylish Haircut",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
