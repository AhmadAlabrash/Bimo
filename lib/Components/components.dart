import 'package:bimo/Cubit/Cubit.dart';
import 'package:bimo/chatScreen/chatScreen.dart';
import 'package:bimo/models/user.dart';
import 'package:bimo/style/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defultButton(
        {@required Color? btncolor,
        @required dynamic btnwidth,
        sizefont,
        textColor,
        height,
        dynamic onpress,
        @required dynamic text}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: btnwidth,
        height: height ?? 60,
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
                  fontSize: sizefont ?? 22,
                  fontWeight: FontWeight.bold,
                  color: textColor == null ? Colors.black : textColor),
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

Widget userChatItem(MyUser model, context) => InkWell(
      onTap: () {
        CubitChatMom.getdata(context)
            .getMessages(reciverId: model.uId)
            .then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatScreen(model)));
        });
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 18, right: 18, bottom: 10, top: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('${model.profileImg}'),
              radius: 30,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 240,
                  child: Text(
                    '${model.bio}',
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.5)),
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(icon: Icon(SoldIcon.Star), onPressed: () {}),
            SizedBox(
              width: 5,
            )
          ],
        ),
      ),
    );
