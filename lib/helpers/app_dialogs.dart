import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppDialogs{
  static AlertDialog showAlertDialog(BuildContext context, String dialogTitle, String dialogContent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle),
          content: Text(dialogContent),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close')),
          ],
        );
    }
  );
}

  static Future<ImageSource> chooseImageSource(BuildContext context) {
    return showDialog<ImageSource>(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            )
    );
  }
}