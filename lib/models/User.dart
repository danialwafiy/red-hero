
class User {

  final String email, name;
  final int id;

  User({
    this.id,
    this.email,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

}


