import 'dart:ffi';

import 'package:bimo/Components/components.dart';
import 'package:bimo/Cubit/Cubit.dart';
import 'package:bimo/Cubit/States.dart';
import 'package:bimo/Sign/chosse_sign.dart';
import 'package:bimo/profile/profile_page.dart';
import 'package:bimo/shared/cache.dart';
import 'package:bimo/style/icon_broken.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitChatMom, StatesChatsMom>(
        listener: (context, state) {},
        builder: (context, state) {
          var heightDev = MediaQuery.of(context).size.height;
          // var heightDevice = MediaQuery.of(context).size.height;
          var widthDevice = MediaQuery.of(context).size.width;
          return SafeArea(
            top: false,
            child: Scaffold(
                body: Column(
              children: [
                Expanded(
                  flex: heightDev <= 600 ? 3 : 1,
                  child: Container(
                    width: widthDevice,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bk.jpg'),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            // SizedBox(
                            //   height: heightDevice * 0.1,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 22, top: 8),
                              child: Text('Bimo',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon:
                                    Icon(SoldIcon.Search, color: Colors.white)),

                            IconButton(
                                onPressed: () {},
                                icon: Icon(SoldIcon.More_Circle,
                                    color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            ChoiceChip(
                              onSelected: (value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Users()),
                                    (route) => false);
                              },
                              label: Text('Chats',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                              selected: false,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            ChoiceChip(
                              onSelected: (val) {},
                              label: Text('Status',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                              selected: false,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            ChoiceChip(
                              onSelected: (value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()),
                                    (route) => false);
                              },
                              label: Text('Profile',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  )),
                              selected: false,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      // borderRadius: BorderRadius.circular(1)
                    ),
                    child: ConditionalBuilder(
                      fallback: (context) => Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      )),
                      condition:
                          CubitChatMom.getdata(context).alluser!.length != 0,
                      builder: (context) => ListView.separated(
                          itemBuilder: (context, index) => userChatItem(
                              CubitChatMom.getdata(context).alluser![index],
                              context),
                          separatorBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Container(
                                  color: Colors.grey[400],
                                  height: 1,
                                  width: double.infinity,
                                ),
                              ),
                          itemCount:
                              CubitChatMom.getdata(context).alluser!.length),
                    ),
                  ),
                ),
              ],
            )),
          );
        });
  }
}
