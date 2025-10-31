import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static CollectionReference doctorCollection = FirebaseFirestore.instance
      .collection('doctor');
  static CollectionReference patientCollection = FirebaseFirestore.instance
      .collection('patient');

  static Future<QuerySnapshot> sortDoctorsByRating() {
    return doctorCollection.orderBy("rating", descending: true).get();
  }

  static Future<QuerySnapshot> filterDoctorsBySpecialization(
    String specialization,
  ) {
    return doctorCollection
        .where("specialization", isEqualTo: specialization)
        .get();
  }

  static Future<QuerySnapshot> searchDoctorsByName(String searchKey) {
    return doctorCollection.orderBy("name").startAt([searchKey]).endAt([
      '$searchKey\uf8ff',
    ]).get();
  }
}
