class UserModel {
  String name;
  String email;

  UserModel({required this.name, required this.email});

  factory UserModel.fromJson(data) {
    return UserModel(
      name: data['name'] ?? 'John Doe',
      email: data['email'] ?? 'hi@johndoe.com',
    );
  }
}
