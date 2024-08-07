import 'package:github_repositories/remote/entities/parents.dart';

import 'commits_author.dart';
import 'commit.dart';

class Commits {
  String? sha;
  String? nodeId;
  Commit? commit;
  String? url;
  String? htmlUrl;
  String? commentsUrl;
  CommitsAuthor? author;
  CommitsAuthor? committer;
  List<Parents>? parents;

  Commits(
      {this.sha,
      this.nodeId,
      this.commit,
      this.url,
      this.htmlUrl,
      this.commentsUrl,
      this.author,
      this.committer,
      this.parents});

  Commits.fromJson(Map<String, dynamic> json) {
    sha = json['sha'];
    nodeId = json['node_id'];
    commit = json['commit'] != null ? Commit.fromJson(json['commit']) : null;
    url = json['url'];
    htmlUrl = json['html_url'];
    commentsUrl = json['comments_url'];
    author =
        json['author'] != null ? CommitsAuthor.fromJson(json['author']) : null;
    committer = json['committer'] != null
        ? CommitsAuthor.fromJson(json['committer'])
        : null;
    if (json['parents'] != null) {
      parents = <Parents>[];
      json['parents'].forEach((v) {
        parents!.add(Parents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sha'] = sha;
    data['node_id'] = nodeId;
    if (commit != null) {
      data['commit'] = commit!.toJson();
    }
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['comments_url'] = commentsUrl;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (committer != null) {
      data['committer'] = committer!.toJson();
    }
    if (parents != null) {
      data['parents'] = parents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
