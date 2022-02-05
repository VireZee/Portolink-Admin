part of 'views.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const String routeName = '/in';
  @override
  _SignInState createState() => _SignInState();
}
class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  final ft = FToast();
  static bool vis = true;
  static bool load = false;
  static bool btn = true;
  bool isEmpty() {
    setState(() {
      if (ctrlEmail.text != '' && ctrlPass.text != '') {
        btn = true;
      }
      else {
        btn = false;
      }
    });
    return btn;
  }
  @override
  void initState() {
    super.initState();
    ft.init(context);
  }
  @override
  void dispose() {
    ctrlEmail.dispose();
    ctrlPass.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}