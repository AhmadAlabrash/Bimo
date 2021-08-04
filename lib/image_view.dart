import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  dynamic imageLink;
  ImageView(this.imageLink);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          width: MediaQuery.of(context).size.width - 50,
          child: Image(
            image: NetworkImage(imageLink),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
