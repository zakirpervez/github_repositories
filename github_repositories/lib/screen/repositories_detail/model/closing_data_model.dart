import 'package:github_repositories/database/app_database.dart';

class ClosingDataModel {
  final RepositoryData repository;
  final List<CommitData> commits;

  ClosingDataModel({required this.repository, required this.commits});

  factory ClosingDataModel.fromJson(Map<String, dynamic> json) {
    return ClosingDataModel(
      repository: RepositoryData.fromJson(json['repository']),
      commits: (json['commits'] as List)
          .map((commit) => CommitData.fromJson(commit))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'repository': repository.toJson(),
      'commits': commits.map((commit) => commit.toJson()).toList(),
    };
  }
}
