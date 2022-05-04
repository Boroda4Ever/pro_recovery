import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // if success
      emit(const AuthSignedIn());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const AuthError("User not found"));
      } else if (e.code == 'wrong-password') {
        emit(const AuthError("Wrong password"));
      }
    }
  }

  Future<void> specialistSignUpWithEmail({
    required String email,
    required String username,
    required String password,
    required String phone,
  }) async {
    emit(const AuthLoading());

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Update DisplayName
      userCredential.user!.updateDisplayName(username);

      // 3. Write user to users collection
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      int id = DateTime.now().millisecondsSinceEpoch;
      await firestore
          .collection("specialists")
          .doc(userCredential.user!.uid)
          .set({
        "email": email,
        "username": username,
        "phone": phone,
        "unique id": id,
      });
      await firestore
          .collection("pairs")
          .doc(id.toString())
          .set({"user id": userCredential.user!.uid});

      await firestore.collection("users").doc(userCredential.user!.uid).set({
        "type": "specialist",
      });
      // if success
      emit(const AuthSignedUp());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthError("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthError("The email is already in use"));
      }
    } catch (e) {
      log(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> patientSignUpWithEmail({
    required String email,
    required String username,
    required String password,
    required String phone,
    required String uniqueId,
  }) async {
    emit(const AuthLoading());

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Update DisplayName
      userCredential.user!.updateDisplayName(username);

      // 3. Write user to users collection
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String specialistId = "";

      await firestore
          .collection('pairs')
          .doc(uniqueId)
          .get()
          .then((value) => specialistId = value.data()!["user id"]);

      await firestore.collection("users").doc(userCredential.user!.uid).set({
        "type": "patient",
      });

      await firestore.collection("patients").doc(userCredential.user!.uid).set({
        "email": email,
        "username": username,
        "phone": phone,
      });

      await firestore.collection("specialists").doc(specialistId).update({
        "specialist patients": {userCredential.user!.uid: "patient"}
      });

      // if success
      emit(const AuthSignedUp());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthError("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthError("The email is already in use"));
      }
    } catch (e) {
      log(e.toString());
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String username,
    required String password,
  }) async {
    emit(const AuthLoading());
    // ...logic

    try {
      // 1. Create user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Update DisplayName
      userCredential.user!.updateDisplayName(username);

      // 3. Write user to users collection
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await userCredential.user!.sendEmailVerification();

      await firestore.collection("users").doc('ABC123').set({
        "email": email,
        "username": username,
      });

      // if success
      emit(const AuthSignedUp());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(const AuthError("The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(const AuthError("The email is already in use"));
      }
    } catch (e) {
      log(e.toString());
      emit(AuthError(e.toString()));
    }
  }
}
