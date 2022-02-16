part of 'views.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.photo, required this.name, required this.desc}) : super(key: key);
  final String photo;
  final String name;
  final String desc;
  @override
  _DetailsState createState() => _DetailsState();
}
class _DetailsState extends State<Details> {
  final CollectionReference tCollection = TemplatesAuth.tCollection;
  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}