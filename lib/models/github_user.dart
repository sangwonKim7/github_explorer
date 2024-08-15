class GitHubUser {
  final String login;
  final String avatarUrl;

  GitHubUser({required this.login, required this.avatarUrl});

  factory GitHubUser.fromJson(Map<String, dynamic> json) {
    return GitHubUser(
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }
}
