part of 'views.dart';

class Update extends StatefulWidget {
  const Update({Key? key, required this.name, required this.email}) : super(key: key);
  final String name;
  final String email;
  @override
  _UpdateState createState() => _UpdateState();
}
class _UpdateState extends State<Update> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ft = FToast();
  static bool load = false;
  final CollectionReference uCollection = FirebaseFirestore.instance.collection('Admins');
  @override
  void initState() {
    ctrlName.text =  widget.name;
    ctrlEmail.text = widget.email;
    super.initState();
    ft.init(context);
  }
  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    return ThemeSwitchingArea(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/update_bg.jpg'),
                fit: BoxFit.fill
              )
            ),
            child: Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
                backgroundColor: Colors.transparent,
                toolbarHeight: 75,
                elevation: 0,
                actions: [
                  ThemeSwitcher(
                    builder: (context) => IconButton(
                      onPressed: () {
                        ThemeSwitcher.of(context).changeTheme(
                          theme: ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.dark
                          ? BlackWhite.lightTheme()
                          : BlackWhite.darkTheme()
                        );
                      },
                      icon: brightness == Brightness.dark ? const Icon(CupertinoIcons.sun_max_fill) : const Icon(CupertinoIcons.moon_stars_fill),
                      color: brightness == Brightness.dark ? Colors.white : Colors.black
                    )
                  )
                ]
              ),
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25
                              )
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: ctrlName,
                              keyboardType: TextInputType.name,
                              style: const TextStyle(
                                fontFamily: 'Flamenco',
                                fontSize: 30
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                              ),
                              maxLines: 1,
                              textInputAction: TextInputAction.next
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25
                              )
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: ctrlEmail,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                fontFamily: 'Flamenco',
                                fontSize: 30
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                              ),
                              maxLines: 1,
                              textInputAction: TextInputAction.done
                            ),
                            const SizedBox(height: 80),
                            Center(
                              child: Material(
                                child: InkWell(
                                  onTap: () async {
                                    setState(() => load = true);
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    final net = await (Connectivity().checkConnectivity());
                                    final sub = await InternetConnectionChecker().hasConnection;
                                    if (net == ConnectivityResult.none) {
                                      setState(() => load = false);
                                      ft.showToast(
                                        child: Activity.showToast(
                                          'No internet connection',
                                          const Color(0xFFFF0000)
                                        ),
                                        toastDuration: const Duration(seconds: 1),
                                        fadeDuration: 200
                                      );
                                    }
                                    else if (ctrlName.text.isEmpty) {
                                      setState(() => load = false);
                                      ft.showToast(
                                        child: Activity.showToast(
                                          'Name can\'t be empty',
                                          const Color(0xFFFF0000)
                                        ),
                                        toastDuration: const Duration(seconds: 1),
                                        fadeDuration: 200
                                      );
                                    }
                                    else if (ctrlEmail.text.isEmpty) {
                                      setState(() => load = false);
                                      ft.showToast(
                                        child: Activity.showToast(
                                          'Email can\'t be empty',
                                          const Color(0xFFFF0000)
                                        ),
                                        toastDuration: const Duration(seconds: 1),
                                        fadeDuration: 200
                                      );
                                    }
                                    else if (sub) {
                                      if (_formKey.currentState!.validate()) {
                                        final Admins admins = Admins(
                                          '',
                                          ctrlName.text,
                                          ctrlEmail.text,
                                          ''
                                        );
                                        final String msg = await Auth.updateAccount(admins);
                                        if (msg == 'Granted') {
                                          setState(() => load = false);
                                          ft.showToast(
                                            child: Activity.showToast(
                                              'Updated',
                                              Colors.blue
                                            ),
                                            toastDuration: const Duration(seconds: 1),
                                            fadeDuration: 200
                                          );
                                        }
                                        else if (msg == 'Existed') {
                                          setState(() => load = false);
                                          ft.showToast(
                                            child: Activity.showToast(
                                              'Email is linked to another account',
                                              const Color(0xFFFF0000)
                                            ),
                                            toastDuration: const Duration(seconds: 1),
                                            fadeDuration: 200
                                          );
                                        }
                                        else if (msg == 'Invalid Email') {
                                          setState(() => load = false);
                                          ft.showToast(
                                            child: Activity.showToast(
                                              'Email is invalid',
                                              const Color(0xFFFF0000)
                                            ),
                                            toastDuration: const Duration(seconds: 1),
                                            fadeDuration: 200
                                          );
                                        }
                                        else if (msg == 'Relog') {
                                          setState(() => load = false);
                                          ft.showToast(
                                            child: Activity.showToast(
                                              'You need to relog',
                                              const Color(0xFFFF0000)
                                            ),
                                            toastDuration: const Duration(seconds: 1),
                                            fadeDuration: 200
                                          );
                                        }
                                      }
                                    }
                                    else {
                                      setState(() => load = false);
                                      ft.showToast(
                                        child: Activity.showToast(
                                          'No internet connection',
                                          const Color(0xFFFF0000)
                                        ),
                                        toastDuration: const Duration(seconds: 1),
                                        fadeDuration: 200
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      gradient: const SweepGradient(
                                        colors: [
                                          Color(0xFF00FF00),
                                          Colors.cyan,
                                          Color(0xFF0000FF),
                                          Colors.purple,
                                          Color(0xFFFF0000),
                                          Colors.yellow,
                                          Colors.yellow,
                                          Color(0xFFFF0000),
                                          Colors.purple,
                                          Color(0xFF0000FF),
                                          Colors.cyan,
                                          Color(0xFF00FF00)
                                        ]
                                      )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Spacer(),
                                        Icon(Icons.update),
                                        Spacer(flex: 4),
                                        Text('Update Profile'),
                                        Spacer(flex: 5),
                                        Spacer()
                                      ]
                                    )
                                  ),
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50))
                              )
                            )
                          ]
                        )
                      )
                    ]
                  )
                ]
              )
            )
          ),
          load == true
          ? Activity.loading()
          : Container()
        ]
      )
    );
  }
}