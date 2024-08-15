import 'package:github_explorer/models/github_repo.dart';
import 'package:github_explorer/models/github_user.dart';
import 'package:github_explorer/core/network/dio_client.dart';

class GitHubService {
  final DioClient _dioClient = DioClient();

  Future<List<GitHubUser>> fetchUsers(int since, int perPage) async {
    final response = await _dioClient.dio.get(
      'https://api.github.com/users',
      queryParameters: {
        'since': since,
        'per_page': perPage,
      },
    );

    return (response.data as List).map((json) => GitHubUser.fromJson(json)).toList();
  }

  Future<List<GithubRepo>> fetchRepos(String username) async {
    final response = await _dioClient.dio.get(
      'https://api.github.com/users/$username/repos',
    );

    return (response.data as List).map((json) => GithubRepo.fromJson(json)).toList();
  }
}
