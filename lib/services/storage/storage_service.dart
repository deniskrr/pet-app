import 'dart:io';

abstract class StorageService {
  Future<String> uploadPhoto(File photo);
}
