import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/core/handler/failer_handler.dart';
import 'package:recipe/core/handler/success_handler.dart';
import 'package:recipe/core/messages/error_messages.dart';
import 'package:recipe/feature/auth/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/auth/data/model/login_with_email_model.dart';
import 'package:recipe/feature/auth/data/model/user_model.dart';
import 'package:recipe/feature/auth/domain/entities/sign_with_email_entities.dart';

class AuthDataSourceRepoImpl implements AuthDataRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  AuthDataSourceRepoImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firebaseFirestore,
  });

  @override
  Future<Either<FailerHandler, SuccessHandler<UserModel>>> loginWithEmail(
    LoginWithEmailModel entities,
  ) async {
    try {
      debugPrint("${entities.email} ${entities.password}");
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: entities.email,
        password: entities.password,
      );
      Map<String, dynamic> userData = await getCurrentUser(
        uid: result.user!.uid,
      );
      return Right(
        SuccessHandlerImpl<UserModel>(
          UserModel(uid: userData["uid"], email: userData["email"]),
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
  Future<Either<FailerHandler, SuccessHandler<UserModel>>>
  loginWithGoogle() async {
    try {
      final userInteraction = await googleSignIn.authenticate();

      final authProvider = GoogleAuthProvider.credential(
        idToken: userInteraction.authentication.idToken,
      );
      final result = await firebaseAuth.signInWithCredential(authProvider);

      Map<String, dynamic> userData = await getCurrentUser(
        uid: result.user!.uid,
      );
      return Right(
        SuccessHandlerImpl<UserModel>(
          UserModel(uid: userData["uid"], email: userData["email"]),
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
  Future<Either<bool, int>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<Either<FailerHandler, SuccessHandler<UserModel>>> registerWithEmail(
    SignWithEmailEntities entities,
  ) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: entities.email,
        password: entities.password,
      );
      await addUser(
        uid: result.user?.uid ?? "",
        email: entities.email,
        name: entities.name,
      );
      return Right(
        SuccessHandlerImpl<UserModel>(
          UserModel(uid: result.user!.uid, email: result.user!.email ?? ""),
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
  Future<Either<FailerHandler, SuccessHandler<UserModel>>>
  registerWithGoogle() async {
    try {
      final userInteraction = await googleSignIn.authenticate();

      final authProvider = GoogleAuthProvider.credential(
        idToken: userInteraction.authentication.idToken,
      );
      final result = await firebaseAuth.signInWithCredential(authProvider);

      await addUser(
        uid: result.user?.uid ?? "",
        email: userInteraction.email,
        name: userInteraction.displayName ?? "",
      );

      return Right(
        SuccessHandlerImpl<UserModel>(
          UserModel(
            uid: result.user?.uid ?? "",
            email: result.user?.email ?? "",
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
