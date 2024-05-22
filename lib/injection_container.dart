import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'core/bloc/core_bloc.dart';
import 'core/network/network_info.dart';
import 'core/utils/pref_utils.dart';
import 'features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/use_cases/login_usecase.dart';
import 'features/authentication/domain/use_cases/logout_usecase.dart';
import 'features/authentication/domain/use_cases/register_usecase.dart';
import 'features/authentication/presentation/bloc/login_bloc/login_bloc.dart';
import 'features/authentication/presentation/bloc/register_bloc/register_bloc.dart';
import 'features/authentication/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'features/chat/data/data_sources/chat_remote_data_source.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat_repository.dart';
import 'features/chat/domain/use_cases/create_conversation_usecase.dart';
import 'features/chat/domain/use_cases/get_conversations_usecase.dart';
import 'features/chat/domain/use_cases/get_messages_usecase.dart';
import 'features/chat/domain/use_cases/send_message_usecase.dart';
import 'features/chat/presentation/bloc/conversations_bloc/conversations_bloc.dart';
import 'features/chat/presentation/bloc/messages_bloc/messages_bloc.dart';
import 'features/manage_user/data/data_sources/user_remote_data_source.dart';
import 'features/manage_user/data/repositories/user_repository_impl.dart';
import 'features/manage_user/domain/repositories/user_repository.dart';
import 'features/manage_user/domain/use_cases/get_all_users_usecase.dart';
import 'features/manage_user/domain/use_cases/get_user_info_usecase.dart';
import 'features/profile/data/data_sources/profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/use_cases/update_task_usecase.dart';
import 'features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'features/projects/data/data_sources/projects_remote_data_source.dart';
import 'features/projects/data/repositories/projects_repository_impl.dart';
import 'features/projects/domain/repositories/projects_repository.dart';
import 'features/projects/domain/use_cases/add_task_usecase.dart';
import 'features/projects/domain/use_cases/create_project_usecase.dart';
import 'features/projects/domain/use_cases/get_all_projects_usecase.dart';
import 'features/projects/domain/use_cases/get_project_by_id_usecase.dart';
import 'features/projects/domain/use_cases/get_project_tasks_usecase.dart';
import 'features/projects/domain/use_cases/update_project_usecase.dart';
import 'features/projects/domain/use_cases/update_task_usecase.dart';
import 'features/projects/presentation/bloc/add_edit_project_bloc/add_edit_project_bloc.dart';
import 'features/projects/presentation/bloc/project_details_bloc/project_details_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => CoreBloc(
      getAllProjectsUseCase: sl(), logoutUseCase: sl(), getUserUseCase: sl()));
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => RegisterBloc(registerUseCase: sl()));
  sl.registerFactory(() => SplashBloc(getUserUseCase: sl()));
  sl.registerFactory(() => AddEditProjectBloc(
      updateProjectUseCase: sl(),
      createProjectUseCase: sl(),
      getAllUsersUseCase: sl()));
  sl.registerFactory(() => ProjectDetailsBloc(
      getProjectTasksUseCase: sl(),
      getProjectByIdUseCase: sl(),
      addTaskUseCase: sl(),
      updateTaskUseCase: sl()));
  sl.registerFactory(
      () => ProfileBloc(updateUserUseCase: sl(), prefUtils: sl()));
  sl.registerFactory(() => ConversationsBloc(
      createConversationUseCase: sl(),
      prefUtils: sl(),
      getConversationsUseCase: sl(),
      getAllUsersUseCase: sl()));
  sl.registerFactory(() => MessagesBloc(
        prefUtils: sl(),
        sendMessageUseCase: sl(),
        getMessagesUseCase: sl(), supabase: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => LogoutUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetUserInfoUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllProjectsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateProjectUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateProjectUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProjectTasksUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProjectByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAllUsersUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateConversationUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetConversationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ProjectsRepository>(
      () => ProjectsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
// DataSources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabase: sl(), prefUtils: sl()));
  sl.registerLazySingleton<ProjectsRemoteDataSource>(
      () => ProjectsRemoteDataSourceImpl(supabase: sl(), prefUtils: sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(supabase: sl(), prefUtils: sl()));
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(supabase: sl(), prefUtils: sl()));
  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(supabase: sl(), prefUtils: sl()));
  //! Core
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<PrefUtils>(
      () => PrefUtilsImpl(sharedPreferences: sl()));
}
