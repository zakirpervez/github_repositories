class Parents {
  String? sha;
  String? url;
  String? htmlUrl;

  Parents({this.sha, this.url, this.htmlUrl});

  Parents.fromJson(Map<String, dynamic> json) {
    sha = json['sha'];
    url = json['url'];
    htmlUrl = json['html_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sha'] = sha;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    return data;
  }
}
