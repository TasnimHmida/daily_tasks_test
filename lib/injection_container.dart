import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'core/network/network_info.dart';
import 'features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/use_cases/get_user_info_usecase.dart';
import 'features/authentication/domain/use_cases/login_usecase.dart';
import 'features/authentication/domain/use_cases/logout_usecase.dart';
import 'features/authentication/domain/use_cases/register_usecase.dart';
import 'features/authentication/presentation/bloc/login_bloc/login_bloc.dart';
import 'features/authentication/presentation/bloc/register_bloc/register_bloc.dart';
import 'features/authentication/presentation/bloc/splash_bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => RegisterBloc(registerUseCase: sl()));
  sl.registerFactory(() => SplashBloc(getUserUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserInfoUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
// DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabase: sl(), prefUtils: sl()));
  //! Core
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}
