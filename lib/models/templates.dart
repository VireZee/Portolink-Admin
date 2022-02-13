part of 'models.dart';

class Templates {
  final String name;
  final String desc;
  final String price;
  const Templates(this.name, this.desc, this.price);
  List<Object> get props => [name, desc, price];
}