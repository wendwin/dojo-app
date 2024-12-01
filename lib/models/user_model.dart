class User {
  final int id;
  final String nama;
  final String email;

  User({required this.id, required this.nama, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return User(
      id: data['id'],
      nama: data['name'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
    };
  }
}
