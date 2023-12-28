import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImage(String childName, Uint8List file, bool isPost) async {
    Reference reference = storage.ref().child(childName).child(auth.currentUser!.uid);

    UploadTask task = reference.putData(file);

    TaskSnapshot snapshot  = await task;

    return snapshot.ref.getDownloadURL();
  }
  Future<String> uploadCover(String childName, Uint8List file) async {
    Reference reference = storage.ref().child(childName).child(auth.currentUser!.uid);

    UploadTask task = reference.putData(file);

    TaskSnapshot snapshot  = await task;

    return snapshot.ref.getDownloadURL();
  }
}