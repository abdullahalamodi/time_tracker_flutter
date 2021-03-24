import 'package:flutter/material.dart';

class Avater extends StatelessWidget {
  const Avater({
    Key key,
    @required this.imgUrl,
    @required this.title,
    this.radius: 50.0,
  }) : super(key: key);
  final imgUrl;
  final String title;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3.0,
                color: Colors.amber,
              )),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.black12,
            backgroundImage: imgUrl != null ? NetworkImage(imgUrl) : null,
            child: imgUrl == null ? Icon(Icons.camera_alt) : null,
          ),
        ),
        if (title != null) Text(title),
        SizedBox(height: 5),
      ],
    );
  }
}
