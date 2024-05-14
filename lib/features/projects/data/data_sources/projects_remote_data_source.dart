import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/utils/pref_utils.dart';
import '../models/project_model.dart';
import '../models/task_model.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModel>> getAllProjects();

  Future<ProjectModel> getProjectById(String projectId);

  Future<Unit> createProject(ProjectModel project);

  Future<Unit> updateProject(ProjectModel project);
  Future<List<TaskModel>> getProjectTasks(String projectId);
  Future<Unit> addTask(TaskModel task);
  Future<Unit> updateTask(TaskModel task);
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
        return projects[0];
      } else {
        throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
      }
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> createProject(ProjectModel project) async {
    try {
      var user = prefUtils.getUserInfo();
      await supabase.from('projects').insert([
        {
          'name': project.name,
          'details': project.details,
          'time': project.time,
          'date': project.date,
          'user_id': user?.userId,
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
      await supabase.from('projects').update({
        'name': project.name,
        'details': project.details,
        'time': project.time,
        'date': project.date,
        'user_id': project.userId,
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
  Future<Unit> addTask(TaskModel task) async {
    var user = prefUtils.getUserInfo();
    try {
      await supabase.from('tasks').insert({
        'name': task.name,
        'is_done': task.isDone,
        'project_id': task.projectId,
        'user_id': user?.userId,
      });

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }

  @override
  Future<Unit> updateTask(TaskModel task) async {
    try {
      await supabase.from('tasks').update({
        'name': task.name,
        'is_done': task.isDone,
        'project_id': task.projectId,
        'user_id': task.userId,
      }).eq('id', task.id ?? '');

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }
}
