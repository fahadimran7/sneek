class UserModel {
  String name;
  String email;
  num balance;

  UserModel({required this.name, required this.email, required this.balance});

  factory UserModel.fromJson(data) {
    return UserModel(
      name: data['name'] ?? 'John Doe',
      email: data['email'] ?? 'hi@johndoe.com',
      balance: data['balance'] ?? 0.0,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'balance': balance,
    };
  }
}
