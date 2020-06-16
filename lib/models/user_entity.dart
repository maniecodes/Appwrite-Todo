class UserEntity {
  final String email;
  final String name;
  final String phone;

  UserEntity(this.email, this.name, this.phone);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          name == other.name &&
          phone == other.phone;

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ phone.hashCode;

  Map<String, Object> toJson() {
    return {'email': email, 'name': name, 'phone': phone};
  }

  @override
  String toString() {
    return 'UserEntity{email: $email, displayName: $name, phone: $phone}';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(json['email'] as String, json['name'] as String,
        json['phone'] as String);
  }
}
