class CommitAuthor {
  String name;
  String email;
  String date;

  CommitAuthor({
    required this.name,
    required this.email,
    required this.date,
  });

  factory CommitAuthor.fromJson(Map<String, dynamic> json) {
    return CommitAuthor(
      name: json['name'],
      email: json['email'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'date': date,
    };
    return data;
  }
}
