part of 'models.dart';

class Requests {
  final String name;
  final String color;
  final String desc;
  final String photo;
  final String contact;
  const Requests(
    this.name,
    this.color,
    this.desc,
    this.photo,
    this.contact
  );
  List<Object> get props => [
    name,
    color,
    desc,
    photo,
    contact
  ];
} 