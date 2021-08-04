import 'package:bimo/Cubit/Cubit.dart';
import 'package:bimo/Cubit/States.dart';
import 'package:bimo/chatScreen/chatScreen.dart';
import 'package:bimo/models/user.dart';
import 'package:bimo/network/dio.dart';
import 'package:bimo/shared/cache.dart';
import 'package:bimo/users/users.dart';
import 'package:bimo/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.blue, // navigation bar color
      // statusBarColor: Colors.pink, // status bar color
      statusBarIconBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();
  MyDio.initDio();
  await Firebase.initializeApp();
  await FirebaseAuth.instance;
  await Cachehelp.init();
  dynamic uid = await Cachehelp.getuid();
  Widget startWidget;
  if (uid != null) {
    startWidget = Users();
  } else {
    startWidget = Welcome();
  }
  print(uid);

  runApp(MyApp(uid, startWidget));
}

class MyApp extends StatelessWidget {
  dynamic uid;
  Widget startWidget;
  MyApp(this.uid, this.startWidget);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitChatMom()..getusers(uid),
      child: BlocConsumer<CubitChatMom, StatesChatsMom>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: ThemeData(primarySwatch: Colors.blueGrey),
          );
        },
      ),
    );
  }
}
