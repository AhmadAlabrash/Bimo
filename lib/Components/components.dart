import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defultButton(
        {@required Color? btncolor,
        @required dynamic btnwidth,
        @required dynamic onpress,
        @required dynamic text}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: btnwidth,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: btncolor,
        ),
        child: Center(
          child: TextButton(
            onPressed: onpress,
            child: Text(
              '$text',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );

Widget defulttextform({
  @required preficon,
  @required label,
  @required TextInputType? texttype,
  @required control,
  invisible = false,
  suficon,
}) =>
    TextFormField(
      keyboardType: texttype,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: preficon,
        suffixIcon: suficon,
        labelText: label,
      ),
      obscureText: invisible,
      controller: control,
      validator: (value) {
        if (value!.isEmpty) {
          return 'you not insert your data';
        }
      },
    );
