part of 'models.dart';

class Templates {
  final String photo;
  final String name;
  final String desc;
  final String price;
  const Templates(
    this.photo,
    this.name,
    this.desc,
    this.price
  );
  List<Object> get props => [
    photo,
    name,
    desc,
    price
  ];
}