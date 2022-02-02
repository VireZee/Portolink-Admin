part of 'models.dart';

class Templates {
  final String name;
  final String desc;
  final String price;
  final String photo;
  const Templates(
    this.name,
    this.desc,
    this.price,
    this.photo
  );
  List<Object> get props => [
    name,
    desc,
    price,
    photo
  ];
}