part of 'views.dart';

class Done extends StatefulWidget {
  const Done({Key? key}) : super(key: key);
  @override
  _DoneState createState() => _DoneState();
}
class _DoneState extends State<Done> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0000FF),
      body: Center(
        child: Text('Hello')
      )
    );
  }
}