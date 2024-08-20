import 'package:dio/dio.dart';
import 'package:github_explorer/models/github_repo.dart';
import 'package:github_explorer/models/github_user.dart';
import 'package:github_explorer/core/network/dio_service.dart';

class GitHubService {
  // final DioClient _dioClient = DioClient();
  final Dio _dio = DioService().dio;

  Future<List<GitHubUser>> fetchUsers(int since, int perPage) async {
    // 'https://api.github.com/users',
    final response = await _dio.get(
      "/users",
      queryParameters: {
        'since': since,
        'per_page': perPage,
      },
    );

    return (response.data as List).map((json) => GitHubUser.fromJson(json)).toList();
  }

  Future<List<GithubRepo>> fetchRepos(String username) async {
    // 'https://api.github.com/users/$username/repos',
    final response = await _dio.get(
      "/users/$username/repos",
    );

    return (response.data as List).map((json) => GithubRepo.fromJson(json)).toList();
  }
}
