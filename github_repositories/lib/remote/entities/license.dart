class License {
  String? key;
  String? name;
  String? spdxId;
  String? url;
  String? nodeId;

  License({this.key, this.name, this.spdxId, this.url, this.nodeId});

  License.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    spdxId = json['spdxId'];
    url = json['url'];
    nodeId = json['nodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['name'] = name;
    data['spdxId'] = spdxId;
    data['url'] = url;
    data['nodeId'] = nodeId;
    return data;
  }
}
