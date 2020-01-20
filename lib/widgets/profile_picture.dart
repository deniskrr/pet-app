import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final File image;
  final String pictureUrl;
  String placeholderImageUri;
  final Function imageGetter;

  ProfilePicture(
      {Key key,
      this.image,
      this.pictureUrl,
      this.placeholderImageUri,
      this.imageGetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.center,
            child: GestureDetector(
              child: CircleAvatar(
                minRadius: 70,
                backgroundImage: image == null
                    ? (pictureUrl.isEmpty
                        ? AssetImage(
                            placeholderImageUri,
                          )
                        : NetworkImage(
                            pictureUrl,
                          ))
                    : FileImage(
                        image,
                      ),
              ),
              onTap: () => imageGetter(),
            ),
          ),
        ),
      ],
    );
  }
}
