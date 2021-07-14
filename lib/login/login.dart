import 'package:bimo/Components/components.dart';
import 'package:bimo/Cubit/Cubit.dart';
import 'package:bimo/Cubit/States.dart';
import 'package:bimo/style/icon_broken.dart';
import 'package:bimo/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitChatMom, StatesChatsMom>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Fluttertoast.showToast(
                msg: "LogIn has done successfuly",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 18.0);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Users()),
                (route) => false);
          }
          if (state is LoginFailed) {
            Fluttertoast.showToast(
                msg: "An error has accourding please try again  ",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 18.0);
          }
        },
        builder: (context, state) => Scaffold(
                body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.23,
                      ),
                      Text('LogIn',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Welcome again we miss you here',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(
                        height: 50,
                      ),

                      defulttextform(
                          texttype: TextInputType.emailAddress,
                          preficon: Icon(SoldIcon.Message),
                          label: 'Email Address',
                          control: emailcontroller),
                      SizedBox(
                        height: 20,
                      ),
                      defulttextform(
                          texttype: TextInputType.visiblePassword,
                          preficon: Icon(SoldIcon.Password),
                          label: 'Password',
                          control: passwordcontroller,
                          invisible: false),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.greenAccent,
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              CubitChatMom.getdata(context).login(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          },
                          child: Text(
                            'Log In',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      )
                      // defultButton(
                      //     btncolor: Colors.greenAccent,
                      //     btnwidth: double.infinity,
                      //     onpress: CubitChatMom.getdata(context).signin(email:emailcontroller.text , password: passwordcontroller.text),
                      //     text: 'Sign In')
                    ],
                  ),
                ),
              ),
            )));
  }
}
