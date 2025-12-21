import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/core/api/clients/dio_client.dart';
import 'package:recipe/core/database/create/create_database.dart';
import 'package:recipe/core/database/tables/areas_table.dart';
import 'package:recipe/core/database/tables/categorys_table.dart';
import 'package:recipe/core/database/tables/foodtypes_table.dart';
import 'package:recipe/core/database/tables/meal_table.dart';
import 'package:recipe/core/database/tables/user_table.dart';
import 'package:recipe/feature/auth/data/data_sources/data_source_repo.dart';
import 'package:recipe/feature/auth/data/data_sources/data_source_repo_impl.dart';
import 'package:recipe/feature/auth/data/data_sources/local_data_source/local_data_impl.dart';
import 'package:recipe/feature/auth/data/data_sources/local_data_source/local_data_repo.dart';
import 'package:recipe/feature/auth/data/data_sources/remote_data_source/remote_data_impl.dart';
import 'package:recipe/feature/auth/data/data_sources/remote_data_source/remote_data_repo.dart';
import 'package:recipe/feature/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:recipe/feature/auth/domain/repo/auth_repo.dart';
import 'package:recipe/feature/auth/domain/use_cases/login_with_email_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/login_with_google_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/signup_with_email_usecase.dart';
import 'package:recipe/feature/auth/domain/use_cases/signup_with_google_usecase.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:recipe/feature/auth/presentation/bloc/auth_ui_bloc/auth_ui_bloc.dart';
import 'package:recipe/feature/dashboard/presentation/dashboard/dashboard_cubit.dart';
import 'package:recipe/feature/home/data/data_source/data_source_repo_impl.dart';
import 'package:recipe/feature/home/data/data_source/local_data_source/local_data_source_repo.dart';
import 'package:recipe/feature/home/data/data_source/local_data_source/local_data_source_repo_impl.dart';
import 'package:recipe/feature/home/data/data_source/remote_data_source/remote_data_source_repo.dart';
import 'package:recipe/feature/home/data/data_source/remote_data_source/remote_data_source_repo_impl.dart';
import 'package:recipe/feature/home/data/repo_impl/home_repo_impl.dart';
import 'package:recipe/feature/home/domain/repo/home_repo.dart';
import 'package:recipe/feature/home/domain/use_cases/home_category.dart';
import 'package:recipe/feature/home/presentation/bloc/home_category_bloc/homecategory_bloc.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/data_sources_repo.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/data_sources_repo_impl.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/local_data_source/local_data_impl_user_sugestion.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/local_data_source/local_data_repo_user_sugestion.dart';
import 'package:recipe/feature/user_sugestion/data/data_sources/remote_data_source/remote_data_impl_user_sugestion.dart';
import 'package:recipe/feature/user_sugestion/data/repo_impl/user_sugestion_repo_impl.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/area_list_use_case.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/category_list_use_case.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/select_area_use_case.dart';
import 'package:recipe/feature/user_sugestion/domain/use_cases/select_category_use_case.dart';
import 'package:recipe/feature/user_sugestion/presentation/bloc/userprefrences_bloc.dart';
import 'package:recipe/feature/user_sugestion/presentation/selected_user_suggestion/area/selectedarea_cubit.dart';
import 'package:recipe/feature/user_sugestion/presentation/selected_user_suggestion/category/selectedcategory_cubit.dart';
import 'package:recipe/feature/welcome/presentation/cubit/pagecurrentindex_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

final sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    /// ~~~~~ Firebase ~~~~~
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );

    /// ~~~~~ Local database ~~~~~
    sl.registerLazySingleton<CreateDatabase>(
      () => CreateDatabase(
        categorysTable: CategorysTable(),
        mealTable: MealTable(),
        userTable: UserTable(),
        areaTable: AreasTable(),
        foodtypesTable: FoodtypesTable(),
      ),
    );

    sl.registerSingletonAsync<Database>(
      () async => await sl<CreateDatabase>().database,
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

    /// ~~~~~~~ Dash Board ~~~~~~~~ implementation
    sl.registerFactory<DashboardCubit>(() => DashboardCubit());

    /// ~~~~~~~ Home ~~~~~~~~ implementation
    _home();
  }

  static void _auth() {
    /// ~~~~~~ Remote data source ~~~~~~
    sl.registerLazySingleton<RemoteDataRepo>(
      () => RemoteDataImpl(
        firebaseAuth: sl(),
        googleSignIn: sl(),
        firebaseFirestore: sl<FirebaseFirestore>(),
      ),
    );

    /// ~~~~~~~~~ Local Data source ~~~~~~~
    sl.registerLazySingleton<LocalDataRepo>(
      () => LocalDataImpl(database: sl<Database>()),
    );

    sl.registerLazySingleton<AuthDataRepo>(
      () => AuthDataSourceRepoImpl(
        remoteData: sl<RemoteDataRepo>(),
        localData: sl<LocalDataRepo>(),
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
    sl.registerLazySingleton<LocalDataRepoUserSugestion>(
      () => LocalDataImplUserSugestion(database: sl<Database>()),
    );

    sl.registerLazySingleton(
      () => RemoteDataImplUserSugestion(
        dio: sl<DioClient>().dio,
        firebaseFirestore: sl<FirebaseFirestore>(),
      ),
    );

    sl.registerLazySingleton<DataSourcesRepo>(
      () => DataSourcesRepoImpl(
        localData: sl<LocalDataRepoUserSugestion>(),
        remoteData: sl<RemoteDataImplUserSugestion>(),
      ),
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
    sl.registerFactory<SelectCategoryUseCase>(
      () => SelectCategoryUseCase(userSugestionRepo: sl<UserSugestionRepo>()),
    );
    sl.registerFactory<SelectAreaUseCase>(
      () => SelectAreaUseCase(userSugestionRepo: sl<UserSugestionRepo>()),
    );

    sl.registerFactory<UserprefrencesBloc>(
      () => UserprefrencesBloc(
        areaListUseCase: sl<AreaListUseCase>(),
        categoryListUseCase: sl<CategoryListUseCase>(),
      ),
    );
    sl.registerFactory<SelectedareaCubit>(
      () => SelectedareaCubit(selectAreaUseCase: sl<SelectAreaUseCase>()),
    );

    sl.registerFactory<SelectedcategoryCubit>(
      () => SelectedcategoryCubit(
        selectCategoryUseCase: sl<SelectCategoryUseCase>(),
      ),
    );
  }

  static void _home() {
    sl.registerLazySingleton<RemoteDataSourceHomeRepo>(
      () => RemoteDataSourceHomeRepoImpl(dio: sl<DioClient>().dio),
    );
    sl.registerLazySingleton<LocalDataSourceHomeRepo>(
      () => LocalDataSourceHomeRepoImpl(database: sl<Database>()),
    );

    sl.registerLazySingleton<DataSourceHomeRepoImpl>(
      () => DataSourceHomeRepoImpl(
        localDataRepo: sl<LocalDataSourceHomeRepo>(),
        remoteDataRepo: sl<RemoteDataSourceHomeRepo>(),
      ),
    );

    sl.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(dataSourceRepo: sl<DataSourceHomeRepoImpl>()),
    );

    sl.registerFactory<HomeCategoryUseCase>(
      () => HomeCategoryUseCase(homeRepo: sl<HomeRepo>()),
    );
    sl.registerFactory<HomecategoryBloc>(
      () => HomecategoryBloc(homeCategoryUseCase: sl<HomeCategoryUseCase>()),
    );
  }

  static Widget intialize(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PagecurrentindexCubit>(create: (context) => sl()),
        BlocProvider<AuthUIBloc>(create: (context) => sl()),
        BlocProvider<AuthBloc>(create: (context) => sl()),
        BlocProvider<UserprefrencesBloc>(create: (context) => sl()),
        BlocProvider<SelectedareaCubit>(create: (context) => sl()),
        BlocProvider<SelectedcategoryCubit>(create: (context) => sl()),
        BlocProvider<DashboardCubit>(create: (context) => sl()),
        BlocProvider<HomecategoryBloc>(create: (context) => sl()),
      ],
      child: child,
    );
  }
}
