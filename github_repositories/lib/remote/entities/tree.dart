class Tree {
  String? sha;
  String? url;

  Tree({this.sha, this.url});

  Tree.fromJson(Map<String, dynamic> json) {
    sha = json['sha'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sha'] = sha;
    data['url'] = url;
    return data;
  }
}
