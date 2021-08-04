import 'package:bimo/Components/components.dart';
import 'package:bimo/Cubit/Cubit.dart';
import 'package:bimo/Cubit/States.dart';
import 'package:bimo/Sign/chosse_sign.dart';
import 'package:bimo/models/user.dart';
import 'package:bimo/shared/cache.dart';
import 'package:bimo/style/icon_broken.dart';
import 'package:bimo/users/users.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyUser mineProfile = CubitChatMom.getdata(context).mineProfile!;
    var nameController = TextEditingController();

    var emailController = TextEditingController();

    var bioController = TextEditingController();

    bioController.text = mineProfile.bio!;
    nameController.text = mineProfile.name!;
    emailController.text = mineProfile.email!;
    return BlocConsumer<CubitChatMom, StatesChatsMom>(
        listener: (context, state) {},
        builder: (context, state) {
          var heightDev = MediaQuery.of(context).size.height;
          var widthDevice = MediaQuery.of(context).size.width;
          return Scaffold(
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
                              icon: Icon(SoldIcon.Search, color: Colors.white)),
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
                      borderRadius: BorderRadius.circular(30)),
                  child: ConditionalBuilder(
                      fallback: (context) => Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                      condition:
                          CubitChatMom.getdata(context).mineProfile != null,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: CircleAvatar(
                                          radius: 75.0,
                                          backgroundImage: CubitChatMom.getdata(
                                                          context)
                                                      .profileImage !=
                                                  null
                                              ? FileImage(CubitChatMom.getdata(
                                                          context)
                                                      .profileImage!)
                                                  as ImageProvider
                                              : NetworkImage(
                                                  '${mineProfile.profileImg}'),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: InkWell(
                                              onTap: () {
                                                CubitChatMom.getdata(context)
                                                    .getProfileImage();
                                              },
                                              child: CircleAvatar(
                                                radius: 15.0,
                                                backgroundColor:
                                                    Colors.grey[400],
                                                child: Center(
                                                  child: Icon(
                                                    SoldIcon.Profile,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                SizedBox(
                                  height: 22,
                                ),
                                defulttextform(
                                    preficon: Icon(SoldIcon.User),
                                    label: 'Name',
                                    texttype: TextInputType.name,
                                    control: nameController),
                                SizedBox(
                                  height: 20,
                                ),
                                defulttextform(
                                    preficon: Icon(SoldIcon.Star),
                                    label: 'Bio',
                                    texttype: TextInputType.name,
                                    control: bioController),
                                SizedBox(
                                  height: 20,
                                ),
                                defulttextform(
                                    preficon: Icon(SoldIcon.Message),
                                    label: 'Email',
                                    texttype: TextInputType.name,
                                    control: emailController),
                                SizedBox(
                                  height: 20,
                                ),
                                defultButton(
                                    btncolor: HexColor("#191970"),
                                    btnwidth: widthDevice,
                                    onpress: () {
                                      CubitChatMom.getdata(context)
                                          .updateUserData(
                                              name: nameController.text,
                                              bio: bioController.text,
                                              email: emailController.text);
                                    },
                                    text: 'Update Profile'),
                                SizedBox(
                                  height: 15,
                                ),
                                defultButton(
                                    btncolor: HexColor("#000066"),
                                    btnwidth: widthDevice,
                                    onpress: () {
                                      Cachehelp.removeuid();
                                      CubitChatMom.getdata(context).logOut();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChosseSign()));
                                    },
                                    text: 'Sign Out')
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ));
        });
  }
}
