import 'package:recipe/feature/auth/data/data_sources/remote_data_source/remote_data_impl.dart';
import 'package:recipe/feature/auth/data/data_sources/remote_data_source/remote_data_repo.dart';
import 'package:recipe/feature/details/domain/repo/detail_repo.dart';
import 'package:recipe/feature/details/domain/usecase/get_detail_usecase.dart';
import 'package:recipe/feature/home/presentation/bloc/home_backtotop_cubit/bactotop_cubit.dart';
import 'package:recipe/feature/user_sugestion/domain/repo/user_sugestion_repo.dart';
import 'package:sqflite/sqflite.dart';
import 'beral_container.dart';

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
        recipesTable: RecipesTable(),
        fooddetailTable: FooddetailTable(),
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

    /// ~~~~~~~~ detail ~~~~~~~~~~~~~ implementaiton
    _detail();

    //// ~~~~~~~~~~~~ Search ~~~~~~~~~~~~ implementation
    _search();
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

    sl.registerFactory<HomeRecipeUseCase>(
      () => HomeRecipeUseCase(repo: sl<HomeRepo>()),
    );
    sl.registerFactory<HomeRecipeBloc>(
      () => HomeRecipeBloc(recipeUseCase: sl<HomeRecipeUseCase>()),
    );

    sl.registerFactory<BactotopCubit>(() => BactotopCubit());
  }

  static void _detail() {
    sl.registerLazySingleton<LocalDataSourceRepo>(
      () => LocalDataSourceRepoImpl(database: sl<Database>().database),
    );
    sl.registerLazySingleton<RemoteDataSourceRepo>(
      () => RemoteDataSourceRepoImpl(dio: sl<DioClient>().dio),
    );
    sl.registerLazySingleton<DetailDatasourceRepo>(
      () => DetailDatasourceRepoImpl(
        localDataSourceRepo: sl<LocalDataSourceRepo>(),
        remoteDataSourceRepo: sl<RemoteDataSourceRepo>(),
      ),
    );

    sl.registerLazySingleton<GetFoodDetailRepo>(
      () => DetailRepoImpl(datasourceRepo: sl<DetailDatasourceRepo>()),
    );

    sl.registerFactory<GetDetailUsecase>(
      () => GetDetailUsecase(getFoodDetailRepo: sl<GetFoodDetailRepo>()),
    );

    sl.registerFactory<DetailBloc>(
      () => DetailBloc(getDetailUseCase: sl<GetDetailUsecase>()),
    );
  }

  static void _search() {
    sl.registerLazySingleton<RemoteSearchDataSourceRepo>(
      () => RemoteSearchDataSourceRepoImpl(dio: sl<DioClient>().dio),
    );
    sl.registerLazySingleton<LocalSearchDataSourceRepo>(
      () => LocalSearchDataSourceRepoImpl(database: sl<Database>().database),
    );
    sl.registerLazySingleton<SearchDataSourceRepo>(
      () => SearchDataSourceRepoImpl(
        localData: sl<LocalSearchDataSourceRepo>(),
        remoteData: sl<RemoteSearchDataSourceRepo>(),
      ),
    );

    sl.registerLazySingleton<SearchDomainRepo>(
      () => SearchDataRepoImpl(dataSourceRepo: sl<SearchDataSourceRepo>()),
    );

    sl.registerFactory<SearchUsecase>(
      () => SearchUsecase(searchDomainRepo: sl<SearchDomainRepo>()),
    );

    sl.registerFactory<SearchBloc>(
      () => SearchBloc(searchUsecase: sl<SearchUsecase>()),
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
        BlocProvider<HomeRecipeBloc>(create: (context) => sl()),
        BlocProvider<DetailBloc>(create: (context) => sl()),
        BlocProvider<SearchBloc>(create: (context) => sl()),
        BlocProvider<BactotopCubit>(create: (context) => sl())
      ],
      child: child,
    );
  }
}
