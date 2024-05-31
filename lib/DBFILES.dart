import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tadza_loan/Models/TransactionModel.dart';

class DBproduct {

  final CollectionReference ProductTable = FirebaseFirestore.instance.collection("transactions");

  DocumentReference ref = FirebaseFirestore.instance.collection("transactions").doc();






  Future uploadImage(File file, {String? path}) async {
    var time = DateTime.now().toString();
    var ext = Path.basename(file.path).split(".")[1].toString();
    String image = path! + "_" + time + "." + ext;
    try {
      Reference ref = FirebaseStorage.instance.ref().child(path! + "/" + image);
      UploadTask upload = ref.putFile(file);
      await upload;
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }


  Future saveProduct(product products) async {
    try {
      await ProductTable.doc(ref.id).set({
        ...products.toMap(),
        'id': ref.id   });
      return true;
    } catch (e) {
      return false;
    }
  }


}