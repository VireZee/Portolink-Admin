part of 'views.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static const String routeName = '/';
  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  final FirebaseAuth auth = Auth.auth;
  final VideoPlayerController vid = VideoPlayerController.asset('assets/images/portolink.mp4');
  final FToast ft = FToast();
  @override
  void initState() {
    super.initState();
    _loadSplash();
    vid.initialize().then((value) {
      vid.setVolume(1);
      vid.setLooping(true);
      vid.play();
    });
    ft.init(context);
  }
  _loadSplash() async {
    const Duration _duration = Duration(seconds: 7);
    return Timer(_duration, checkAuth);
  }
  void checkAuth() async {
    if (auth.currentUser != null) {
      final String? ctrlName = auth.currentUser!.displayName;
      Navigator.pushReplacementNamed(context, '/main');
      ft.showToast(
        child: Activity.showToast(
          'Welcome Back, ' + ctrlName!.split(' ').first,
          Colors.blue
        ),
        toastDuration: const Duration(seconds: 1),
        fadeDuration: 200
      );
    }
    else {
      Navigator.pushReplacementNamed(context, '/in');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // children: <LottieBuilder>[Lottie.asset('assets/images/loading.json')]
      )
    );
  }
}