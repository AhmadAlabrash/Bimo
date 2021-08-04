import 'package:bimo/Cubit/Cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class MyDio {
  static Dio? dioItem;

  static initDio() async {
    dioItem = Dio(BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm',
        receiveDataWhenStatusError: true));
  }

  static Future sendNotification({
    @required name,
    @required token,
  }) async {
    dioItem!.options.headers = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAAjI3vIzc:APA91bGwvQYqAy6ooDWzNx-a0s7LSSN8xn-cDznGltoYxY7kfofOEjlwUX_CjXh-eHIwEGMFOzG8IGeX4bhii7NaHPjxBpThFd3a6Mv2pZynkhL93ZD50XEuA8MuuFitfapRemljfTN0"
    };
    return await dioItem!.post('/send', data: {
      "to": token,
      "notification": {
        "title": "New Message !",
        "body": "$name has sent you a message",
        "mutable_content": true,
        "sound": "Tri-tone"
      },
      "data": {
        "url": "<url of media image>",
        "dl": "<deeplink action on tap of notification>"
      }
    });
  }
}
