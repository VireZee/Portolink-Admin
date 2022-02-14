part of 'views.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String routeName = '/up';
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName =  TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  final ctrlCPass = TextEditingController();
  final ft = FToast();
  bool vis = true;
  bool load = false;
  bool btn = true;
  bool isEmpty() {
    setState(() {
      if (ctrlName.text != '' && ctrlEmail.text != '' && ctrlPass.text != '' && ctrlCPass.text != '') {
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
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPass.dispose();
    ctrlCPass.dispose();
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
                  const Flexible(
                    child: Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontFamily: 'Oswald',
                          fontSize: 60
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                                FontAwesomeIcons.user,
                                size: 28
                              )
                            ),
                            hintText: 'Name'
                          ),
                          controller: ctrlName,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                          textInputAction: TextInputAction.next
                        )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
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
                                FontAwesomeIcons.checkCircle,
                                size: 28
                              )
                            ),
                            hintText: 'Confirm Pass'
                          ),
                          obscureText: vis,
                          controller: ctrlCPass,
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
                        else if (ctrlPass.text != ctrlCPass.text) {
                          setState(() => load = false);
                          ft.showToast(
                            child: Activity.showToast(
                              'Password isn\'t match',
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
                              ctrlPass.text
                            );
                            final String msg = await Auth.signUp(admins);
                            if (msg == 'Signed') {
                              setState(() => load = false);
                              ft.showToast(
                                child: Activity.showToast(
                                  'You can Sign In now',
                                  Colors.blue
                                ),
                                toastDuration: const Duration(seconds: 1),
                                fadeDuration: 200
                              );
                              Navigator.pushReplacementNamed(context, '/in');
                            }
                            else if (msg == 'Existed') {
                              setState(() => load = false);
                              ft.showToast(
                                child: Activity.showToast(
                                  'Email is already taken',
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
                            else if (msg == 'Invalid Pass') {
                              setState(() => load = false);
                              ft.showToast(
                                child: Activity.showToast(
                                  'Password is too weak',
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
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                        )
                      ),
                      icon: const Icon(Icons.verified_user),
                      label: Row(
                        children: const [
                          Spacer(),
                          Text(
                            'SIGN UP',
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
                    onTap: () => Navigator.pushReplacementNamed(context, '/in'),
                    child: const Text(
                      'Already Have an Account',
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