class Client {
  int? id;
  String photoPath;
  String name;
  String lastName;
  String email;
  String password;

  Client({
    this.id,
    required this.photoPath,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "photoPath": photoPath,
      "name": name,
      "lastName": lastName,
      "email": email,
      "password": password,
    };
  }

  factory Client.fromMap(Map<String, dynamic> map) {
    return Client(
      id: map["id"] ?? 0,
      photoPath: map["photoPath"] as String,
      name: map["name"] as String,
      lastName: map["lastName"] as String,
      email: map["email"] as String,
      password: map["password"] as String,
    );
  }

}