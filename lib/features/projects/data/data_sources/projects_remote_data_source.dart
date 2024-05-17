import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../../manage_user/data/models/user_model.dart';
import '../models/project_model.dart';
import '../models/task_model.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModel>> getAllProjects();

  Future<ProjectModel> getProjectById(String projectId);

  Future<Unit> createProject(ProjectModel project);

  Future<Unit> updateProject(ProjectModel project);

  Future<List<TaskModel>> getProjectTasks(String projectId);

  Future<Unit> addTask(TaskModel task, double percentage);

  Future<Unit> updateTask(TaskModel task, double percentage);
}

class ProjectsRemoteDataSourceImpl implements ProjectsRemoteDataSource {
  final PrefUtils prefUtils;
  final SupabaseClient supabase;

  ProjectsRemoteDataSourceImpl(
      {required this.supabase, required this.prefUtils});

  @override
  Future<List<ProjectModel>> getAllProjects() async {
    try {
      var user = prefUtils.getUserInfo();
      final response = await supabase
          .from('projects')
          .select()
          .eq('user_id', user?.userId ?? '');

      final List<ProjectModel> projects = response
          .map<ProjectModel>((jsonModel) => ProjectModel.fromJson(jsonModel))
          .toList();

      return projects;
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  Future<List<UserModel>> fetchMembersFromJson(List<String> members) async {
    List<UserModel> users = [];

    for (String memberId in members) {
      final res = await supabase.from('members').select().eq('user_id', memberId);

      UserModel userModel = UserModel.fromJson(res[0]);
      users.add(userModel);
    }

    return users;
  }

  @override
  Future<ProjectModel> getProjectById(String projectId) async {
    try {
    var user = prefUtils.getUserInfo();
    final response = await supabase
        .from('projects')
        .select()
        .eq('user_id', user?.userId ?? '')
        .eq('id', projectId);

    final List<ProjectModel> projects = response
        .map<ProjectModel>((jsonModel) => ProjectModel.fromJson(jsonModel))
        .toList();

    if (projects.isNotEmpty) {
      final members = await fetchMembersFromJson((projects[0].members ?? []).map((user) => user.userId ?? '').toList());
      return ProjectModel(
          name: projects[0].name,
          id: projects[0].id,
          details: projects[0].details,
          time: projects[0].time,
          date: projects[0].date,
          percentage: projects[0].percentage,
          userId: projects[0].userId,
          members: members);
    } else {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  Map<String, dynamic> userListToJson(List<UserModel> users) {
    Map<String, dynamic> jsonMap = {};
    for (UserModel user in users) {
      // Add each user's id and profilePicture to the jsonMap
      jsonMap[user.userId!] = user.profilePicture;
    }
    return jsonMap;
  }

  @override
  Future<Unit> createProject(ProjectModel project) async {
    try {
      Map<String, dynamic> jsonMembers = userListToJson(project.members ?? []);
      var user = prefUtils.getUserInfo();
      await supabase.from('projects').insert([
        {
          'name': project.name,
          'details': project.details,
          'time': project.time,
          'date': project.date,
          'user_id': user?.userId,
          'members': jsonMembers
        }
      ]);

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> updateProject(ProjectModel project) async {
    try {
      Map<String, dynamic> jsonMembers = userListToJson(project.members ?? []);

      await supabase.from('projects').update({
        'name': project.name,
        'details': project.details,
        'time': project.time,
        'date': project.date,
        'user_id': project.userId,
        'members': jsonMembers
      }).eq('id', project.id ?? '');

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<List<TaskModel>> getProjectTasks(String projectId) async {
    try {
      var user = prefUtils.getUserInfo();
      final response = await supabase
          .from('tasks')
          .select()
          .eq('user_id', user?.userId ?? '')
          .eq('project_id', projectId);

      final List<TaskModel> tasks = response
          .map<TaskModel>((jsonModel) => TaskModel.fromJson(jsonModel))
          .toList();

      return tasks;
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> addTask(TaskModel task, double percentage) async {
    var user = prefUtils.getUserInfo();
    try {
      await supabase.from('tasks').insert({
        'name': task.name,
        'is_done': task.isDone,
        'project_id': task.projectId,
        'user_id': user?.userId,
      });

      await supabase.from('projects').update({
        'completed_percentage': percentage,
      })
          // .eq('user_id', task.userId ?? '')
          .eq('id', task.projectId ?? '');

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> updateTask(TaskModel task, double percentage) async {
    try {
      await supabase.from('tasks').update({
        'name': task.name,
        'is_done': task.isDone,
        'project_id': task.projectId,
        'user_id': task.userId,
      }).eq('id', task.id ?? '');
      await supabase
          .from('projects')
          .update({
            'completed_percentage': percentage,
          })
          .eq('user_id', task.userId ?? '')
          .eq('id', task.projectId ?? '');
      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }
}
