class GithubRepo {
  final String name;
  final String? description;
  final int stargazersCount;
  final String? language;

  GithubRepo({
    required this.name,
    this.description,
    required this.stargazersCount,
    this.language,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    return GithubRepo(
      name: json['name'],
      description: json['description'],
      stargazersCount: json['stargazers_count'],
      language: json['language'],
    );
  }
}