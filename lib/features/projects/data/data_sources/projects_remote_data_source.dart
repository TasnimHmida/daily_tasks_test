import 'package:dartz/dartz.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/strings/failures.dart';
import '../../../../core/utils/pref_utils.dart';
import '../models/project_model.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModel>> getAllProjects();

  Future<Unit> createProject(ProjectModel project);

  Future<Unit> updateProject(ProjectModel project);
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
      var user = prefUtils.getUserInfo();
      await supabase.from('projects').update({
        'name': project.name,
        'details': project.details,
        'time': project.time,
        'date': project.date,
        'user_id': user?.userId,
      }).eq('id', project.id ?? '');

      return Future.value(unit);
    } catch (e) {
      throw ServerException(message: UNEXPECTED_FAILURE_MESSAGE);
    }
  }
}
