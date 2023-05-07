import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  static final userCollection = FirebaseFirestore.instance.collection('Users');
  static final branchCollection =
      FirebaseFirestore.instance.collection('BRANCHES');

  // get date selector selected Date
  static Future<DocumentReference> getSelectedDateData(
      String branch, String yearAndMonth, String day) async {
    DocumentReference document = await FirebaseFirestore.instance
        .collection('BRANCHES')
        .doc(branch)
        .collection(yearAndMonth /**2023-April */)
        .doc(day);

    return document;
  }

  // get month in date selector
  static Future<QuerySnapshot> getSelectedMonthData(
      String branch, String yearAndMonth) async {
    QuerySnapshot document = await FirebaseFirestore.instance
        .collection('BRANCHES')
        .doc(branch)
        .collection(yearAndMonth /**2023-April */)
        .get();

    return document;
  }
}

class GetBranchReference extends StatelessWidget {
  const GetBranchReference({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
