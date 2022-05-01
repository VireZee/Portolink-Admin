part of 'views.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}
class _OrderState extends State<Order> {
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