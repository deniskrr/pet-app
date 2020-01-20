import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_app/services/storage/storage_service.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageService extends StorageService {
  FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> uploadPhoto(File photo) async {
    String path = Uuid().v1();
    StorageReference ref = _storage.ref().child('images/$path');
    StorageUploadTask uploadTask = ref.putFile(photo);
    await uploadTask.onComplete;
    return await ref.getDownloadURL();
  }
}
