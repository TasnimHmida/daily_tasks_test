import 'package:daily_tasks_test/core/network/network_info.dart';
import 'package:daily_tasks_test/core/utils/pref_utils.dart';
import 'package:daily_tasks_test/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:daily_tasks_test/features/authentication/domain/repositories/auth_repository.dart';
import 'package:daily_tasks_test/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:daily_tasks_test/features/authentication/domain/use_cases/logout_usecase.dart';
import 'package:daily_tasks_test/features/authentication/domain/use_cases/register_usecase.dart';
import 'package:daily_tasks_test/features/chat/data/data_sources/chat_remote_data_source.dart';
import 'package:daily_tasks_test/features/chat/domain/repositories/chat_repository.dart';
import 'package:daily_tasks_test/features/chat/domain/use_cases/create_conversation_usecase.dart';
import 'package:daily_tasks_test/features/chat/domain/use_cases/get_conversations_usecase.dart';
import 'package:daily_tasks_test/features/chat/domain/use_cases/get_messages_usecase.dart';
import 'package:daily_tasks_test/features/chat/domain/use_cases/send_message_usecase.dart';
import 'package:daily_tasks_test/features/manage_user/data/data_sources/user_remote_data_source.dart';
import 'package:daily_tasks_test/features/manage_user/domain/repositories/user_repository.dart';
import 'package:daily_tasks_test/features/manage_user/domain/use_cases/get_all_users_usecase.dart';
import 'package:daily_tasks_test/features/manage_user/domain/use_cases/get_user_info_usecase.dart';
import 'package:daily_tasks_test/features/notifications/data/data_sources/notification_remote_data_source.dart';
import 'package:daily_tasks_test/features/notifications/domain/repositories/notification_repository.dart';
import 'package:daily_tasks_test/features/notifications/domain/use_cases/create_new_notification_usecase.dart';
import 'package:daily_tasks_test/features/notifications/domain/use_cases/get_notifications_usecase.dart';
import 'package:daily_tasks_test/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:daily_tasks_test/features/profile/domain/repositories/profile_repository.dart';
import 'package:daily_tasks_test/features/profile/domain/use_cases/update_user_usecase.dart';
import 'package:daily_tasks_test/features/projects/data/data_sources/projects_remote_data_source.dart';
import 'package:daily_tasks_test/features/projects/domain/repositories/projects_repository.dart';
import 'package:daily_tasks_test/features/projects/domain/use_cases/add_task_usecase.dart';
import 'package:daily_tasks_test/features/projects/domain/use_cases/create_project_usecase.dart';
import 'package:daily_tasks_test/features/projects/domain/use_cases/get_all_projects_usecase.dart';
import 'package:daily_tasks_test/features/projects/domain/use_cases/get_project_by_id_usecase.dart';
import 'package:daily_tasks_test/features/projects/domain/use_cases/get_project_tasks_usecase.dart';
import 'package:daily_tasks_test/features/projects/domain/use_cases/update_project_usecase.dart';
import 'package:daily_tasks_test/features/projects/domain/use_cases/update_task_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

@GenerateMocks([
  LoginUseCase,
  LogoutUseCase,
  RegisterUseCase,
  CreateConversationUseCase,
  GetConversationsUseCase,
  GetMessagesUseCase,
  SendMessageUseCase,
  GetAllUsersUseCase,
  GetUserInfoUseCase,
  CreateNewNotificationUseCase,
  GetNotificationsUseCase,
  UpdateUserUseCase,
  AddTaskUseCase,
  UpdateTaskUseCase,
  CreateProjectUseCase,
  UpdateProjectUseCase,
  GetAllProjectsUseCase,
  GetProjectTasksUseCase,
  GetProjectByIdUseCase,
  AuthRepository,
  AuthRemoteDataSource,
  ProjectsRepository,
  ProjectsRemoteDataSource,
  ChatRepository,
  ChatRemoteDataSource,
  NotificationsRepository,
  NotificationsRemoteDataSource,
  ProfileRepository,
  ProfileRemoteDataSource,
  UserRepository,
  UserRemoteDataSource,
  NetworkInfo,
  PrefUtils,
], customMocks: [
  MockSpec<SupabaseClient>(as: #MockSupabaseClient)
])
void main() {}
