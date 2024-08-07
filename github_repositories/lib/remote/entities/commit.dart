
import 'package:github_repositories/remote/entities/tree.dart';
import 'package:github_repositories/remote/entities/verification.dart';

import 'commit_author.dart';

class Commit {
  CommitAuthor? author;
  CommitAuthor? committer;
  String? message;
  Tree? tree;
  String? url;
  int? commentCount;
  Verification? verification;

  Commit(
      {this.author,
      this.committer,
      this.message,
      this.tree,
      this.url,
      this.commentCount,
      this.verification});

  Commit.fromJson(Map<String, dynamic> json) {
    author =
        json['author'] != null ? CommitAuthor.fromJson(json['author']) : null;
    committer = json['committer'] != null
        ? CommitAuthor.fromJson(json['committer'])
        : null;
    message = json['message'];
    tree = json['tree'] != null ? Tree.fromJson(json['tree']) : null;
    url = json['url'];
    commentCount = json['comment_count'];
    verification = json['verification'] != null
        ? Verification.fromJson(json['verification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (committer != null) {
      data['committer'] = committer!.toJson();
    }
    data['message'] = message;
    if (tree != null) {
      data['tree'] = tree!.toJson();
    }
    data['url'] = url;
    data['comment_count'] = commentCount;
    if (verification != null) {
      data['verification'] = verification!.toJson();
    }
    return data;
  }
}
