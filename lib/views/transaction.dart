part of 'views.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);
  @override
  _TransactionState createState() => _TransactionState();
}
class _TransactionState extends State<Transaction> {
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