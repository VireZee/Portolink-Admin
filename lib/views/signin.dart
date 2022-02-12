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
  bool vis = true;
  bool load = false;
  bool btn = true;
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
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/begin_bg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)
              )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  Flexible(
                    child: Center(
                      child: Column(
                        children: const [
                          Spacer(flex: 10),
                          Text(
                            'Admin',
                            style: TextStyle(
                              fontFamily: 'Dancing Script',
                              color: Color(0xFF0000FF),
                              fontSize: 80
                            )
                          ),
                          Spacer()
                        ]
                      )
                    )
                  ),
                  const Flexible(
                    child: Center(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 60
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]!.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: TextField(
                          onChanged: (value) => isEmpty(),
                          style: const TextStyle(fontSize: 25),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Icon(
                                FontAwesomeIcons.envelope,
                                size: 28
                              )
                            ),
                            hintText: 'Email'
                          ),
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]!.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: TextField(
                          onChanged: (value) => isEmpty(),
                          style: const TextStyle(fontSize: 25),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Icon(
                                FontAwesomeIcons.lock,
                                size: 28
                              )
                            ),
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () => setState(() => vis = !vis),
                              child: Icon(
                                vis
                                ? Icons.visibility
                                : Icons.visibility_off
                              )
                            )
                          ),
                          obscureText: vis,
                          controller: ctrlPass,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: isEmpty()
                      ? () async {
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
                        else if (ctrlPass.text.isEmpty) {
                          setState(() => load = false);
                          ft.showToast(
                            child: Activity.showToast(
                              'Password can\'t be empty',
                              const Color(0xFFFF0000)
                            ),
                            toastDuration: const Duration(seconds: 1),
                            fadeDuration: 200
                          );
                        }
                        else if (sub) {
                          if (_formKey.currentState!.validate()) {
                            final String msg = await Auth.signIn(ctrlEmail.text, ctrlPass.text);
                            if (msg == 'Granted') {
                              setState(() => load = false);
                              Navigator.pushReplacementNamed(context, '/main');
                            }
                            else if (msg == 'None') {
                              setState(() => load = false);
                              ft.showToast(
                                child: Activity.showToast(
                                  'Email is not exist',
                                  const Color(0xFFFF0000)
                                ),
                                toastDuration: const Duration(seconds: 1),
                                fadeDuration: 200
                              );
                            }
                            else if (msg == 'Hacker') {
                              setState(() => load = false);
                              ft.showToast(
                                child: Activity.showToast(
                                  'Password is wrong',
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
                            else if (msg == 'Disabled') {
                              setState(() => load = false);
                              ft.showToast(
                                child: Activity.showToast(
                                  'This email has been disabled',
                                  const Color(0xFFFF0000)
                                ),
                                toastDuration: const Duration(seconds: 1),
                                fadeDuration: 200
                              );
                            }
                            else if (msg == 'Denied') {
                              setState(() => load = false);
                              ft.showToast(
                                child: Activity.showToast(
                                  'Access Denied',
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
                      }
                      : null,
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith((states) {
                          return states.contains(MaterialState.pressed)
                          ? Colors.blue
                          : null;
                        }),
                        foregroundColor: MaterialStateProperty.resolveWith((states) {
                          return states.contains(MaterialState.pressed)
                          ? const Color(0xFF00FF00)
                          : null;
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        )
                      ),
                      icon: const Icon(Icons.login),
                      label: Row(
                        children: const [
                          Spacer(),
                          Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontFamily: 'Prompt',
                              fontSize: 20
                            )
                          ),
                          Spacer(flex: 2)
                        ]
                      )
                    )
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/up');
                    },
                    child: const Text(
                      'Create New Account',
                      style: TextStyle(
                        fontFamily: 'Flamenco',
                        fontSize: 30,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1
                      )
                    )
                  ),
                  const SizedBox(height: 20)
                ]
              )
            )
          )
        ),
        load == true
        ? Activity.check()
        : Container()
      ]
    );
  }
}