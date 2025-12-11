import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/core/api/clients/dio_client.dart';
import 'package:recipe/feature/auth/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/auth/data/data_sources/data_source_repo_impl.dart';
import 'package:recipe/feature/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:recipe/feature/auth/domain/repo/auth_repo.dart';
import 'package:recipe/feature/auth/domain/use_cases/login_with_email_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/login_with_google_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/signup_with_email_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/signup_with_google_usecase.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_ui_bloc/auth_ui_bloc.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/data_sources_repo.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/data_sources_repo_impl.dart';
import 'package:recipe/feature/user_sugestion/data/repo_impl/user_sugestion_repo_impl.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/area_list_use_case.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/category_list_use_case.dart';
import 'package:recipe/feature/user_sugestion/presentation/bloc/userprefrences_bloc.dart';
import 'package:recipe/feature/welcome/presentation/cubit/pagecurrentindex_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    /// ~~~~~ Firebase ~~~~~
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );

    // ~~~~~ Google sign ~~~~~~~
    sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);
    await sl<GoogleSignIn>().initialize(
      clientId:
          "275643301370-r6hmoov7b6qit1rm445ei50tlud0t7jj.apps.googleusercontent.com",
    );

    /// ~~~~ onboarding cubit ~~ implementation
    sl.registerFactory<PagecurrentindexCubit>(() => PagecurrentindexCubit());

    /// ~~~~~~~~~ dio ~~~~~~~~~~~
    sl.registerLazySingleton<DioClient>(() => DioClient());

    /// ~~~~ Auth bloc's ~~~~ implementation
    _auth();

    /// ~~~~~ User Sugestion ~~~~~ implementation
    _userSugestion();
  }

  static void _auth() {
    sl.registerLazySingleton<AuthDataRepo>(
      () => AuthDataSourceRepoImpl(
        firebaseAuth: sl(),
        googleSignIn: sl(),
        firebaseFirestore: sl<FirebaseFirestore>(),
      ),
    );
    sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(dataRepo: sl()));

    sl.registerFactory<LoginWithEmailUsecase>(
      () => LoginWithEmailUsecase(authRepo: sl()),
    );
    sl.registerFactory<SignupWithEmailUsecase>(
      () => SignupWithEmailUsecase(authRepo: sl()),
    );

    sl.registerFactory<LoginWithGoogleUsecase>(
      () => LoginWithGoogleUsecase(authRepo: sl()),
    );
    sl.registerFactory<SignupWithGoogleUsecase>(
      () => SignupWithGoogleUsecase(authRepo: sl()),
    );
    sl.registerFactory<AuthBloc>(
      () => AuthBloc(
        login: sl(),
        sigup: sl(),
        google: sl(),
        registerGoogle: sl(),
      ),
    );
    sl.registerFactory<AuthUIBloc>(() => AuthUIBloc());
  }

  static void _userSugestion() {
    sl.registerLazySingleton<DataSourcesRepo>(
      () => DataSourcesRepoImpl(dio: sl<DioClient>().dio),
    );
    sl.registerLazySingleton<UserSugestionRepo>(
      () => UserSugestionRepoImpl(dataSourcesRepo: sl()),
    );

    sl.registerFactory<AreaListUseCase>(
      () => AreaListUseCase(userSugestionRepo: sl<UserSugestionRepo>()),
    );
    sl.registerFactory<CategoryListUseCase>(
      () => CategoryListUseCase(userSugestionRepo: sl<UserSugestionRepo>()),
    );

    sl.registerFactory<UserprefrencesBloc>(
      () => UserprefrencesBloc(
        areaListUseCase: sl<AreaListUseCase>(),
        categoryListUseCase: sl<CategoryListUseCase>(),
      ),
    );
  }

  static Widget intialize(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PagecurrentindexCubit>(create: (context) => sl()),
        BlocProvider<AuthUIBloc>(create: (context) => sl()),
        BlocProvider<AuthBloc>(create: (context) => sl()),
        BlocProvider<UserprefrencesBloc>(create: (context) => sl()),
      ],
      child: child,
    );
  }
}
