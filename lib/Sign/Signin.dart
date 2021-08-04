import 'package:bimo/Components/components.dart';
import 'package:bimo/Cubit/Cubit.dart';
import 'package:bimo/Cubit/States.dart';
import 'package:bimo/shared/cache.dart';
import 'package:bimo/style/icon_broken.dart';
import 'package:bimo/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var namecontroller = TextEditingController();

  var emailcontroller = TextEditingController();

  var passwordcontroller = TextEditingController();

  var phonecontroller = TextEditingController();

  var biocontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();
  var passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitChatMom, StatesChatsMom>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Fluttertoast.showToast(
                msg: "Sign In has done successfuly",
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
          if (state is SignInFailed) {
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
                        height: MediaQuery.of(context).size.height * 0.13,
                      ),
                      Text('Sign In',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Now you will chat with all your freinds',
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(
                        height: 50,
                      ),
                      defulttextform(
                          texttype: TextInputType.name,
                          preficon: Icon(SoldIcon.User),
                          label: 'Name',
                          control: namecontroller),
                      SizedBox(
                        height: 20,
                      ),
                      defulttextform(
                          texttype: TextInputType.phone,
                          preficon: Icon(SoldIcon.Call),
                          label: 'Phone',
                          control: phonecontroller,
                          invisible: false),
                      SizedBox(
                        height: 20,
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
                          suficon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                print('$passwordVisible');
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          label: 'Password',
                          control: passwordcontroller,
                          invisible: !passwordVisible),
                      SizedBox(
                        height: 20,
                      ),
                      defulttextform(
                          texttype: TextInputType.text,
                          preficon: Icon(SoldIcon.Show),
                          label: 'Bio',
                          control: biocontroller,
                          invisible: false),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey[400],
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              CubitChatMom.getdata(context).signin(
                                  bio: biocontroller.text,
                                  name: namecontroller.text,
                                  phone: phonecontroller.text,
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          },
                          child: Text(
                            'Sign In',
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
