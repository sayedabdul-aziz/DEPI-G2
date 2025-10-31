import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety/feature/auth/data/models/doctor_model.dart';
import 'package:se7ety/feature/auth/data/models/patient_model.dart';
import 'package:se7ety/feature/auth/data/models/user_type_enum.dart';
import 'package:se7ety/feature/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? specialization;
  String? imageUrl;

  final bioController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final addressController = TextEditingController();
  final openHourController = TextEditingController();
  final closeHourController = TextEditingController();

  login() async {
    emit(AuthLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthErrorState('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthErrorState('Wrong password provided for that user.'));
      } else {
        emit(AuthErrorState(e.code));
      }
    }
  }

  register({required UserTypeEnum userType}) async {
    emit(AuthLoadingState());
    // register with firebase
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
      User? user = credential.user;
      user?.updateDisplayName(nameController.text);
      //! Use photoURL to store user role
      user?.updatePhotoURL(userType == UserTypeEnum.doctor ? "2" : "1");
      // email and uid, display name, Role

      // store user data into firestore (Target Db)
      if (userType == UserTypeEnum.doctor) {
        var model = DoctorModel(
          name: nameController.text,
          email: emailController.text,
          uid: user?.uid,
          rating: 3,
        );
        await FirebaseFirestore.instance
            .collection('doctor')
            .doc(user?.uid)
            .set(model.toJson());
      } else {
        var model = PatientModel(
          name: nameController.text,
          email: emailController.text,
          uid: user?.uid,
        );

        await FirebaseFirestore.instance
            .collection('patient')
            .doc(user?.uid)
            .set(model.toJson());
      }

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthErrorState('كلمة المرور ضعيفة'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthErrorState('البريد الالكتروني مستخدم بالفعل'));
      } else {
        emit(AuthErrorState('حدث خطأ ما'));
      }
    } catch (e) {
      emit(AuthErrorState('حدث خطأ ما'));
    }
  }

  updateDoctorData() async {
    emit(AuthLoadingState());

    var model = DoctorModel(
      uid: FirebaseAuth.instance.currentUser?.uid,
      bio: bioController.text,
      phone1: phone1Controller.text,
      phone2: phone2Controller.text,
      address: addressController.text,
      openHour: openHourController.text,
      closeHour: closeHourController.text,
      specialization: specialization,
      image: imageUrl,
    );

    try {
      await FirebaseFirestore.instance
          .collection('doctor')
          .doc(model.uid)
          .update(model.toUpdateData());
      emit(AuthSuccessState());
    } on Exception catch (_) {
      emit(AuthErrorState('حدث خطأ ما'));
    }
  }
}
