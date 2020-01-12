import 'package:flutter/services.dart';

class ErrorMessages {

  static String getErrorMessage(PlatformException e) {
    String errorType = e.message;
    return errorType;
  }
}