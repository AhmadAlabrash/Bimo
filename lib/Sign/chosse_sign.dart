import 'package:bimo/Components/components.dart';
import 'package:bimo/Sign/Signin.dart';
import 'package:bimo/login/login.dart';
import 'package:flutter/material.dart';

class ChosseSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Spacer(
            flex: 1,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
            )),
          ),
          Spacer(
            flex: 1,
          ),
          defultButton(
              onpress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              btncolor: Colors.greenAccent,
              btnwidth: double.infinity,
              text: 'LogIn'),
          SizedBox(
            height: 20,
          ),
          defultButton(
              onpress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
              btncolor: Colors.lightBlue,
              btnwidth: double.infinity,
              text: 'SignIn'),
          Spacer(
            flex: 2,
          ),
        ],
      )),
    );
  }
}
