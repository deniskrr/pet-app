import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  final String imageUrl;
  final ImageProvider placeHolder;

  const ImageTile({Key key, @required this.imageUrl, @required this.placeHolder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageUrl.isEmpty
              ? placeHolder
              : NetworkImage(
                  imageUrl,
                ),
        ),
      ),
    );
  }
}
