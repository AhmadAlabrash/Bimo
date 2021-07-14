import 'package:bimo/Sign/chosse_sign.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.66,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/welcome.jpg'),
              fit: BoxFit.cover,
            )),
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            'Welcome to our chat app',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'here you can make all chats and calls with very big security and safety ',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.5)),
            ),
          ),
          Spacer(
            flex: 2,
          ),

          // ignore: deprecated_member_use
          Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ChosseSign()),
                      (route) => false);
                },
                child: Text('Skip',
                    style: TextStyle(
                        fontSize: 20, color: Colors.black.withOpacity(0.5))),
              ))
        ],
      ),
    );
  }
}
