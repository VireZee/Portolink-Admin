part of 'views.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}
class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF00FF00),
      body: Center(
        child: Text('Hello')
      )
    );
  }
}