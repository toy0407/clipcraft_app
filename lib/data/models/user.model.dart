class UserModel {
  final String id;
  final String? name;
  final String email;
  final String? avatarUrl;

  UserModel({required this.id, required this.email, this.name, this.avatarUrl});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(id: map['id'], email: map['email'], name: map['name'], avatarUrl: map['avatarUrl']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'avatarUrl': avatarUrl};
  }
}
