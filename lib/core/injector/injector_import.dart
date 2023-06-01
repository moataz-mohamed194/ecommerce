part of'injector.dart';

var sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory(() => EyesCubit());
  sl.registerFactory(() => BottomNavigatorCubit());
  sl.registerFactory(() => CheckBoxCubit());
  sl.registerFactory(() => DropDownBloc());
  sl.registerFactory(() => ChooseFileCubit());


  //Bloc

  sl.registerFactory(() => AddProfileBloc(
      getProfile: sl()));
  sl.registerFactory(() => LoginBloc(
      loginAccount: sl()));
  sl.registerFactory(() => AddProductBloc(
      addProduct: sl(), editProduct: sl(), getProductCart: sl(), deleteProduct: sl()));
  sl.registerFactory(() => HomeBloc(getProductData: sl(), getOneProductData: sl(), deleteOneProductData: sl(), getAllCategories: sl(), getProductSearchData: sl(), addToCart: sl()));
  sl.registerFactory(() => SignUpBloc(
      signUpAccount: sl()));

  //UseCase
  sl.registerLazySingleton(() => LoginAccountData(sl()));
  sl.registerLazySingleton(() => UpdateProductFromCartAccountData(sl()));
  sl.registerLazySingleton(() => DeleteProductFromCartAccountData(sl()));
  sl.registerLazySingleton(() => GetProductToCartAccountData(sl()));
  sl.registerLazySingleton(() => AddProductToCartAccountData(sl()));
  sl.registerLazySingleton(() => GetAllCategoriesDataUseCases(sl()));
  sl.registerLazySingleton(() => GetProductsSearchDataUseCases(sl()));
  sl.registerLazySingleton(() => GetProfileAccountData(sl()));
  sl.registerLazySingleton(() => AddProductAccountData(sl()));
  sl.registerLazySingleton(() => EditProductAccountData(sl()));
  sl.registerLazySingleton(() => ProductDataUseCases(sl()));
  sl.registerLazySingleton(() => OneProductDataUseCases(sl()));
  sl.registerLazySingleton(() => SignUpAccountData(sl()));
  sl.registerLazySingleton(() => DeleteOneProductUseCases(sl()));

  //Repository
  sl.registerLazySingleton<GetProfileRepository>(
          () => ProfileRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<LoginRepository>(
          () => loginRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AddProductRepository>(
          () => ProductRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ProductRepository>(
          () => productRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<SignUpRepository>(
          () => signUpRepositoriesImpl(remoteDataSource: sl(), networkInfo: sl()));

//Datasources
  sl.registerLazySingleton<GetProfileRemoteDataSource>(
          () => GetProfileRemoteDataSourceImple(client: sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(
          () => LoginRemoteDataSourceImple(client: sl()));
  sl.registerLazySingleton<AddProductRemoteDataSource>(
          () => AddProductRemoteDataSourceImple(client: sl()));
  sl.registerLazySingleton<ProductRemoteDataSource>(
          () => ProductRemoteDataSourceImple(client: sl()));
  sl.registerLazySingleton<SignUpRemoteDataSource>(
          () => SignUpRemoteDataSourceImple(client: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
