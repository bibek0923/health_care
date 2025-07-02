import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class StorageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;
  RxString imageUrl = ''.obs;

  Future<void> uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = storage.ref().child("healthCareHub_images/$fileName.jpg");

      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String url = await snapshot.ref.getDownloadURL();
      imageUrl.value = url;
      log("Image uploaded successfully: $url");
    } catch (e) {
      log("Upload failed: $e");
    }
  }

  RxList<String>? reportUrls = <String>[].obs;


  Future<List<String>> uploadReports(List<dynamic> files) async {
    try {
      for (var item in files) {
        File? pdf;

        if (item is File) {
          pdf = item;
        } else if (item is PlatformFile && item.path != null) {
          pdf = File(item.path!);
        }

        if (pdf != null) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".pdf";
          Reference ref = FirebaseStorage.instance.ref().child("healthCareHub_files/$fileName");

          UploadTask uploadTask = ref.putFile(pdf);
          TaskSnapshot snapshot = await uploadTask;

          String downloadUrl = await snapshot.ref.getDownloadURL();
          reportUrls!.add(downloadUrl);
          debugPrint("PDF uploaded: $downloadUrl");
        } else {
          debugPrint("Invalid file or path is null");
        }
      }
    } catch (e) {
      debugPrint("Upload failed: $e");
    }

    return reportUrls!;
  }

}
