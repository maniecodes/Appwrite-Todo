import 'package:appwrite_project/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String name;
  final String phone;

  User(this.email, {String name = '', String phone = ''})
      : this.name = name ?? '',
        this.phone = phone ?? '';

  User copyWith({String email, String name, String phone}) {
    return User(email ?? this.email,
        name: name ?? this.name, phone: phone ?? this.phone);
  }

  @override
  List<Object> get props => [email, name, phone];

  UserEntity toEntity() {
    return UserEntity(email, name, phone);
  }

  static User fromEntity(UserEntity entity) {
    return User(entity.email, name: entity.name, phone: entity.phone);
  }
}
