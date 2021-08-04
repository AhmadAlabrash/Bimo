import 'dart:io';

import 'package:bimo/Cubit/States.dart';
import 'package:bimo/models/message.dart';
import 'package:bimo/models/user.dart';
import 'package:bimo/shared/cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CubitChatMom extends Cubit<StatesChatsMom> {
  CubitChatMom() : super(IntializMom());

  static CubitChatMom getdata(context) => BlocProvider.of(context);

  Future signin(
      {@required name,
      @required phone,
      @required email,
      @required bio,
      @required password}) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await FirebaseMessaging.instance.getToken().then((va) async {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set({
          'uId': value.user!.uid,
          'email': email,
          'password': password,
          'name': name,
          'phone': phone,
          'bio': bio,
          'message_token': va,
          'profile_img':
              'https://firebasestorage.googleapis.com/v0/b/bimo-f849e.appspot.com/o/profile.webp?alt=media&token=04a51a8e-d8c4-4e35-bef7-b59253eae4f3'
        }).then((val) async {
          await Cachehelp.setuid(uidString: value.user!.uid);
          await getusers(value.user!.uid);
          Cachehelp.setuid(uidString: value.user!.uid);

          emit(SignInSuccess());
        });
      }).catchError((error) {
        print('my errorrrrrrrrrr is $error ');
        emit(SignInFailed());
      });
    });
  }

  Future login({@required email, @required password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await Cachehelp.setuid(uidString: value.user!.uid);
      await getusers(value.user!.uid);

      emit(LoginSuccess());
    }).catchError((error) {
      print('my errorrrrrrrrrr is $error ');
      emit(LoginFailed());
    });
  }

  List<MyUser>? alluser = [];
  MyUser? mineProfile;

  Future getusers(uid) async {
    alluser = [];
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element["uId"] != uid) {
          alluser!.add(MyUser.fromJson(element.data()));
        } else {
          mineProfile = MyUser.fromJson(element.data());
        }
      });
      getMyId();
      emit(GetusersSuccess());
    }).catchError((error) {
      emit(GetusersFailed());
    });
  }

  String? myId;
  Future getMyId() async {
    myId = await Cachehelp.getuid();
  }

  Future sendMessage({
    @required reciverId,
    @required messageText,
    @required date,
    @required imageLink,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add({
      'messageText': '$messageText',
      'imageLink': '$imageLink',
      'date': '$date',
      'ReciverId': '$reciverId',
    }).then((value) {
      sendMessageAnotherUser(
          reciverId: reciverId,
          messageText: messageText,
          date: date,
          imageLink: imageLink);
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageFailed());
    });
  }

  Future sendMessageAnotherUser({
    @required reciverId,
    @required messageText,
    @required date,
    @required imageLink,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(myId)
        .collection('messages')
        .add({
      'messageText': '$messageText',
      'imageLink': '$imageLink',
      'date': '$date',
      'ReciverId': '$reciverId',
    }).then((value) {
      emit(SendMessageAnotherSuccess());
    }).catchError((error) {
      emit(SendMessageAnotherFailed());
    });
  }

  List<Message> allmessage = [];
  Future getMessages({
    @required reciverId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      emit(GetMessageSuccess());
      allmessage = [];
      event.docs.forEach((element) {
        allmessage.add(Message.fromJson(element.data()));
      });
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(ChangeProfileImageSuccess());
      uploadImage();
    } else {
      emit(ChangeProfileImageFailed());
    }
  }

  Future uploadImage() async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(myId)
            .update({'profile_img': value});
      });
    });
  }

  Future updateUserData({
    @required name,
    @required bio,
    @required email,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(myId).update({
      'email': email,
      'name': name,
      'bio': bio,
    }).then((value) {
      getusers(myId);
      emit(ChangeProfileDataSuccess());
    }).catchError((error) => emit(ChangeProfileDataFailed()));
  }

  File? sentImage;

  Future<void> sentImageFuncation({
    @required reciverId,
    @required date,
  }) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      sentImage = File(pickedFile.path);

      emit(SendImageAnotherSuccess());
      uploadSentImage(reciverId: reciverId, date: date);
    } else {
      emit(SendImageAnotherFailed());
    }
  }

  Future uploadSentImage({
    @required reciverId,
    @required date,
  }) async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(sentImage!.path).pathSegments.last}')
        .putFile(sentImage!)
        .then((val) {
      val.ref.getDownloadURL().then((value) async {
        await sendMessage(
                reciverId: reciverId,
                messageText: 'empty',
                date: date,
                imageLink: value)
            .then((va) async {});
      });
    });
  }

//   Future getTokenFcm() async {
//     FirebaseMessaging messaging = await FirebaseMessaging.instance;

// use the returned token to send messages to users from your custom server
//     String? token = await messaging.getToken().then((value) {
//       print('token is ::::: $value');
//     }).catchError((er) {
//       print('error is ::::: $er');
//     });

//    }

  Future logOut() async {
    return myId = profileImage = mineProfile = alluser = null;
  }
}
