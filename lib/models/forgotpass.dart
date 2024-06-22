class Forgot {
  final bool user;
  final bool email;

  Forgot({required this.user, required this.email});

  factory Forgot.fromJson(Map<String, dynamic> json) {
    return Forgot(
      user: json['user'] ?? false,
      email: json['email'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'email': email,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Forgot(user:$user,, email:$email)";
  }
}
