class User {
  final int id;
  final String username;
  final String token;

  User(
      {required this.id,
      required this.username,
      required this.token});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
      id: data['id'],
      username: data['username'],
      token: data['token'],
  );

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "username": username,
        "token": token
      };
}