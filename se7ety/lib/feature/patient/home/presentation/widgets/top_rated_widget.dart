import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/services/firebase/firestore_services.dart';
import 'package:se7ety/core/widgets/doctor_card.dart';
import 'package:se7ety/feature/auth/data/models/doctor_model.dart';

// Firestore Summary

//! get
//1) specific document => Collection + doc ID
//2) list of documents => Collection
// - get all documents(get) => collection.get()
// - get all documents with real-time updates (snapshots) => collection.snapshots()
// - sorting (orderBy) => collection.orderBy('fieldName', descending: true/false).get()
// - filter (where) => collection.where('fieldName', isEqualTo: value).get()
// - search (startAt / endAt) => collection.orderBy('fieldName').startAt([value]).endAt([value + '\uf8ff']).get()
// - pagination (limit) => collection.limit(number).get()

//! set
// specific document => Collection + doc ID

//! update
// specific document => Collection + doc ID

//! delete
// specific document => Collection + doc ID

class TopRatedList extends StatefulWidget {
  const TopRatedList({super.key});

  @override
  State<TopRatedList> createState() => _TopRatedListState();
}

class _TopRatedListState extends State<TopRatedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: FirestoreServices.sortDoctorsByRating(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                value: .9,
                color: Colors.black12,
              ),
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data?.docs.length, // all doctors in firebase
              itemBuilder: (context, index) {
                DoctorModel doctor = DoctorModel.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>,
                );
                if (doctor.specialization == null ||
                    doctor.specialization?.isEmpty == true) {
                  return const SizedBox();
                }
                return DoctorCard(doctor: doctor);
              },
            );
          }
        },
      ),
    );
  }
}
