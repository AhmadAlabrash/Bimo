import 'package:bimo/Cubit/Cubit.dart';
import 'package:bimo/Cubit/States.dart';
import 'package:bimo/image_view.dart';
import 'package:bimo/models/user.dart';
import 'package:bimo/network/dio.dart';
import 'package:bimo/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  MyUser model;
  ChatScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitChatMom, StatesChatsMom>(
        listener: (context, state) {},
        builder: (context, state) {
          MyUser mineProfile = CubitChatMom.getdata(context).mineProfile!;
          var messageController = TextEditingController();
          var heightDevice = MediaQuery.of(context).size.height;
          var widthDevice = MediaQuery.of(context).size.width;
          return
              //  Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: AssetImage('assets/images/bk.jpg'),
              //           fit: BoxFit.cover)),
              //   child:
              Scaffold(
            body: Container(
              height: heightDevice,
              width: widthDevice,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bk.jpg'),
                      fit: BoxFit.cover)),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 2),
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: Colors.white.withOpacity(0),
                        titleSpacing: 0,
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(SoldIcon.Arrow___Left)),
                        title: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage('${model.profileImg}'),
                              radius: 22,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${model.name}',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                  Text('${model.bio}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[400],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          IconButton(
                              icon: Icon(SoldIcon.More_Circle),
                              onPressed: () {}),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            if (model.uId ==
                                CubitChatMom.getdata(context)
                                    .allmessage[index]
                                    .reciverId) {
                              if (CubitChatMom.getdata(context)
                                      .allmessage[index]
                                      .imageLink !=
                                  'empty') {
                                return myImageMessage(
                                    CubitChatMom.getdata(context)
                                        .allmessage[index]
                                        .imageLink,
                                    context);
                              } else {
                                return myMessage(CubitChatMom.getdata(context)
                                    .allmessage[index]
                                    .messageText);
                              }
                            } else {
                              if (CubitChatMom.getdata(context)
                                      .allmessage[index]
                                      .imageLink !=
                                  'empty') {
                                return anotherImageMessage(
                                    CubitChatMom.getdata(context)
                                        .allmessage[index]
                                        .imageLink,
                                    context);
                              } else {
                                return anotherMessage(
                                    CubitChatMom.getdata(context)
                                        .allmessage[index]
                                        .messageText);
                              }
                            }
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 1,
                              ),
                          itemCount:
                              CubitChatMom.getdata(context).allmessage.length),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      controller: messageController,
                                      onFieldSubmitted: (val) {
                                        CubitChatMom.getdata(context)
                                            .sendMessage(
                                                imageLink: 'empty',
                                                reciverId: model.uId,
                                                messageText:
                                                    messageController.text,
                                                date: DateTime.now())
                                            .then((value) {
                                          MyDio.sendNotification(
                                              name: mineProfile.name,
                                              token: model.message_token);
                                        });
                                      },
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          hintText: 'Type a message ',
                                          hintStyle: TextStyle(
                                              wordSpacing: 3,
                                              color: Colors.grey,
                                              fontSize: 18),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.emoji_emotions_outlined,
                                        color: Colors.grey)),

                                // SizedBox(
                                //   width: 4,
                                // ),
                                IconButton(
                                    onPressed: () {
                                      CubitChatMom.getdata(context)
                                          .sentImageFuncation(
                                              reciverId: model.uId,
                                              date: DateTime.now());
                                    },
                                    icon: Icon(SoldIcon.Camera,
                                        color: Colors.grey)),
                                IconButton(
                                    onPressed: () {
                                      CubitChatMom.getdata(context)
                                          .sendMessage(
                                              imageLink: 'empty',
                                              reciverId: model.uId,
                                              messageText:
                                                  messageController.text,
                                              date: DateTime.now())
                                          .then((value) {
                                        MyDio.sendNotification(
                                            name: mineProfile.name,
                                            token: model.message_token);
                                      });
                                    },
                                    icon: Icon(SoldIcon.Send,
                                        color: Colors.grey)),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget myMessage(text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Text(
            '$text',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
      ),
    );

Widget anotherMessage(text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Text(
            '$text',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
      ),
    );

Widget myImageMessage(link, context) => InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ImageView(link)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(link),
                width: 230,
                height: 160,
              )),
        ),
      ),
    );

Widget anotherImageMessage(link, context) => InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ImageView(link)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(link),
                width: 230,
                height: 160,
              )),
        ),
      ),
    );
