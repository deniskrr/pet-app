import 'package:flutter/material.dart';
import 'dart:io';

class AppReusableWidgets {
  static Widget profilePicture(File image, String pictureUrl, String placeHolderPictureUrl, Function getImage) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
                          placeHolderPictureUrl,
                        )
                      : NetworkImage(
                          pictureUrl,
                        ))
                  : FileImage(
                      image,
                    ),
            ),
            onTap: () => getImage(),
          ),
        ),
      ),
    ]);
  }
}
