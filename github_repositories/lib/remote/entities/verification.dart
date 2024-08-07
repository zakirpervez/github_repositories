class Verification {
  bool? verified;
  String? reason;
  Null signature;
  Null payload;

  Verification({this.verified, this.reason, this.signature, this.payload});

  Verification.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    reason = json['reason'];
    signature = json['signature'];
    payload = json['payload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verified'] = verified;
    data['reason'] = reason;
    data['signature'] = signature;
    data['payload'] = payload;
    return data;
  }
}
