import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cachehelp {
  static SharedPreferences? shared;

  static Future init() async {
    shared = await SharedPreferences.getInstance();
  }

  static Future setuid({@required uidString}) async {
    return await shared!.setString('uid', uidString);
  }

  static Future getuid() async {
    return await shared!.get('uid');
  }

  static Future removeuid() async {
    return await shared!.clear();
  }
}
