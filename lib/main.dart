import 'package:bimo/Cubit/Cubit.dart';
import 'package:bimo/Cubit/States.dart';
import 'package:bimo/shared/cache.dart';
import 'package:bimo/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance;
  await Cachehelp.init();
  dynamic uid = await Cachehelp.getuid();
  print(uid);

  runApp(MyApp(uid));
}

class MyApp extends StatelessWidget {
  dynamic uid;
  MyApp(this.uid);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitChatMom(),
      child: BlocConsumer<CubitChatMom, StatesChatsMom>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Welcome(),
        ),
      ),
    );
  }
}
