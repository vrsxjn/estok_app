class User {
  int id;
  String name;
  String token;
  String email;
  String telefone;

  User({this.id, this.name, this.token, this.email, this.telefone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] != null ? (json["id"] as num).toInt() : null,
      name: (json["nome"] as String),
      token: (json["token"] as String),
      email: (json["email"] as String),
      telefone: (json["telefone"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": this.id,
      "nome": this.name,
      "email": this.email,
      "token": this.token,
      "telefone": this.telefone,
    };
  }
}
