import 'package:bimo/Cubit/States.dart';
import 'package:bimo/shared/cache.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitChatMom extends Cubit<StatesChatsMom> {
  CubitChatMom() : super(IntializMom());

  static CubitChatMom getdata(context) => BlocProvider.of(context);

  Future signin(
      {@required name,
      @required phone,
      @required email,
      @required password}) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(value.user!.uid)
          .set({
        'email': email,
        'password': password,
        'name': name,
        'phone': phone
      }).then((val) {
        Cachehelp.setuid(uidString: value.user!.uid);

        emit(SignInSuccess());
      });
    }).catchError((error) {
      print('my errorrrrrrrrrr is $error ');
      emit(SignInFailed());
    });
  }

  Future login({@required email, @required password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Cachehelp.setuid(uidString: value.user!.uid);

      emit(LoginSuccess());
    }).catchError((error) {
      print('my errorrrrrrrrrr is $error ');
      emit(LoginFailed());
    });
  }
}
