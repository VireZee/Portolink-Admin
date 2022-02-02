part of 'models.dart';

class Pendings {
  final String status;
  final String text;
  const Pendings(
    this.status,
    this.text
  );
  List<Object> get props => [
    status,
    text
  ];
}