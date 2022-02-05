part of 'views.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static const String routeName = '/';
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ft = FToast();
  @override
  void initState() {
    super.initState();
    _loadSplash();
    ft.init(context);
  }
  _loadSplash() async {
    var _duration = const Duration(seconds: 5);
    return Timer(_duration, checkAuth);
  }
  void checkAuth() async {
    if (auth.currentUser != null) {
      final ctrlName = auth.currentUser!.displayName;
      Navigator.pushReplacementNamed(context, '/main');
      ft.showToast(
        child: Activity.showToast(
          'Welcome Back, ' + ctrlName!.split(' ').first,
          Colors.blue
        ),
        toastDuration: const Duration(seconds: 1),
        fadeDuration: 200
      );
    } else {
      Navigator.pushReplacementNamed(context, '/in');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}