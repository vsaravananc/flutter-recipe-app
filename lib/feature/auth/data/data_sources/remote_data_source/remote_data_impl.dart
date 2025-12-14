import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/core/messages/error_messages.dart';
import 'package:recipe/feature/auth/data/data_sources/remote_data_source/remote_data_repo.dart';
import 'package:recipe/feature/auth/data/model/login_with_email_model.dart';
import 'package:recipe/feature/auth/data/model/user_model.dart';
import 'package:recipe/feature/auth/domain/entities/sign_with_email_entities.dart';

typedef EitherBoolOrInt = Either<bool, int>;

class RemoteDataImpl implements RemoteDataRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  RemoteDataImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firebaseFirestore,
  });

  @override
  Future<GetUser> loginWithEmail(LoginWithEmailModel entities) async {
    try {
      debugPrint("${entities.email} ${entities.password}");
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: entities.email,
        password: entities.password,
      );
      Map<String, dynamic> userData = await getCurrentUser(
        uid: result.user!.uid,
      );
      await addUser(
        uid: result.user!.uid,
        email: userData["email"],
        name: userData["name"],
      );
      return Right(
        SuccessHandlerImpl<UserModel>(
          UserModel(
            uid: result.user!.uid,
            email: userData["email"],
            name: userData["name"],
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return Left(
        FireBaseFailure(ErrorMessages.getFirebaseErrorMessage(e.code)),
      );
    } catch (m) {
      debugPrint(m.toString());
      return Left(
        ServerFailure(
          "We’re unable to reach the server right now. Please check your connection or try again later.",
        ),
      );
    }
  }

  @override
  Future<GetUser> loginWithGoogle() async {
    try {
      final userInteraction = await googleSignIn.authenticate();

      final authProvider = GoogleAuthProvider.credential(
        idToken: userInteraction.authentication.idToken,
      );
      final result = await firebaseAuth.signInWithCredential(authProvider);

      Map<String, dynamic> userData = await getCurrentUser(
        uid: result.user!.uid,
      );

      await addUser(
        uid: result.user?.uid ?? "",
        email: userData["email"],
        name: userData["name"],
      );
      return Right(
        SuccessHandlerImpl<UserModel>(
          UserModel(
            uid: userData["uid"],
            email: userData["email"],
            name: userData["name"],
          ),
        ),
      );
    } on GoogleSignInException catch (e) {
      debugPrint(e.code.toString());
      return Left(
        FireBaseFailure(ErrorMessages.getGoogleSignInErrorMessage(e.code)),
      );
    } on FirebaseException catch (e) {
      debugPrint(e.code);
      return Left(
        FireBaseFailure(ErrorMessages.getFirebaseErrorMessage(e.code)),
      );
    } catch (m) {
      debugPrint(m.toString());
      return Left(
        ServerFailure(
          "We’re unable to reach the server right now. Please check your connection or try again later.",
        ),
      );
    }
  }

  @override
  Future<EitherBoolOrInt> logout() {
    throw UnimplementedError();
  }

  @override
  Future<GetUser> registerWithEmail(SignWithEmailEntities entities) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: entities.email,
        password: entities.password,
      );
      return Right(
        SuccessHandlerImpl<UserModel>(
          UserModel(
            uid: result.user!.uid,
            email: result.user!.email ?? "",
            name: result.user!.displayName ?? "",
          ),
        ),
      );
    } on FirebaseException catch (e) {
      debugPrint(e.code);
      return Left(
        FireBaseFailure(ErrorMessages.getFirebaseErrorMessage(e.code)),
      );
    } catch (m) {
      debugPrint(m.toString());
      return Left(
        ServerFailure(
          "We’re unable to reach the server right now. Please check your connection or try again later.",
        ),
      );
    }
  }

  @override
  Future<GetUser> registerWithGoogle() async {
    try {
      final userInteraction = await googleSignIn.authenticate();

      final authProvider = GoogleAuthProvider.credential(
        idToken: userInteraction.authentication.idToken,
      );
      final result = await firebaseAuth.signInWithCredential(authProvider);

      return Right(
        SuccessHandlerImpl<UserModel>(
          UserModel(
            uid: result.user?.uid ?? "",
            email: result.user?.email ?? "",
            name: result.user?.displayName ?? "",
          ),
        ),
      );
    } on GoogleSignInException catch (e) {
      debugPrint(e.code.toString());
      return Left(
        FireBaseFailure(ErrorMessages.getGoogleSignInErrorMessage(e.code)),
      );
    } on FirebaseException catch (e) {
      debugPrint(e.code);
      return Left(
        FireBaseFailure(ErrorMessages.getFirebaseErrorMessage(e.code)),
      );
    } catch (m) {
      debugPrint(m.toString());
      return Left(
        ServerFailure(
          "We’re unable to reach the server right now. Please check your connection or try again later.",
        ),
      );
    }
  }

  @override
  Future<void> addUser({
    required String uid,
    required String email,
    required String name,
  }) async {
    try {
      await firebaseFirestore.collection("users").doc(uid).set({
        "email": email,
        "name": name,
      });
    } catch (e) {
      debugPrint('add Error : $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser({required String uid}) async {
    try {
      final doc = await firebaseFirestore.collection("users").doc(uid).get();
      if (!doc.exists) {
        throw Exception("No such user found");
      }
      final data = doc.data()!;
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
