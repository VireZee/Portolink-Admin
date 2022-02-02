part of 'models.dart';

class Users {
  final String photo;
  final String name;
  final String email;
  final String password;
  const Users(
    this.photo,
    this.name,
    this.email,
    this.password
  );
  List<Object> get props => [
    photo,
    name,
    email,
    password
  ];
}