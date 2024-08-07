import 'package:github_repositories/base/arguments/base_arguments.dart';
import 'package:github_repositories/database/app_database.dart';

final class RepositoryDetailsArguments extends BaseArguments{
  final int index;
  final RepositoryData repository;

  RepositoryDetailsArguments({required this.index, required this.repository});

  factory RepositoryDetailsArguments.fromJson(Map<String, dynamic> json) {
    return RepositoryDetailsArguments(
      index: json['index'],
      repository: RepositoryData.fromJson(json['repository']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'repository': repository.toJson(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is RepositoryDetailsArguments &&
              runtimeType == other.runtimeType &&
              index == other.index &&
              repository == other.repository);

  @override
  int get hashCode => index.hashCode ^ repository.hashCode;

  @override
  String toString() {
    return 'RepositoryDetailsArguments{index: $index, repository: $repository}';
  }
}
