part of 'views.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);
  static const String routeName = '/add';
  @override
  _AddState createState() => _AddState();
}
class _AddState extends State<Add> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ctrlName = TextEditingController();
  final TextEditingController ctrlDesc = TextEditingController();
  final TextEditingController ctrlPrice = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  XFile? imgFile;
  final FToast ft = FToast();
  bool load = false;
  bool btn = true;
  Future<dynamic> chooseFile() async {
    const ImageSource imgSrc = ImageSource.gallery;
    final XFile? selectedImage = await imagePicker.pickImage(
      source: imgSrc,
      imageQuality: 100
    );
    setState(() => imgFile = selectedImage);
  }
  bool isEmpty() {
    setState(() {
      if (ctrlName.text != '' && ctrlDesc.text != '' && ctrlPrice.text != '' && imgFile != null) {
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
    ctrlDesc.dispose();
    ctrlPrice.dispose();
    super.dispose();
  }
  void clearForm() {
    ctrlName.clear();
    ctrlDesc.clear();
    ctrlPrice.clear();
    setState(() => imgFile = null);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Container>[
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/edit_bg.jpg'),
              fit: BoxFit.fill
            )
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
              backgroundColor: Colors.transparent,
              toolbarHeight: 75,
              elevation: 0,
              title: const Text('Add a New Template'),
              centerTitle: true
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <ListView>[
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  physics: const BouncingScrollPhysics(),
                  children: <Form>[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Name',
                            style: TextStyle(fontSize: 15)
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (value) => isEmpty(),
                            controller: ctrlName,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                            ),
                            maxLines: 1,
                            textInputAction: TextInputAction.next
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Description',
                            style: TextStyle(fontSize: 15)
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (value) => isEmpty(),
                            controller: ctrlDesc,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                            ),
                            maxLines: 3,
                            textInputAction: TextInputAction.next
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Price',
                            style: TextStyle(fontSize: 15)
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            onChanged: (value) => isEmpty(),
                            controller: ctrlPrice,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                            ),
                            maxLines: 1,
                            textInputAction: TextInputAction.done
                          ),
                          const SizedBox(height: 16),
                          imgFile == null
                          ? Row(
                            children: <Widget>[
                              ElevatedButton.icon(
                                onPressed: () => chooseFile(),
                                icon: const Icon(Icons.image),
                                label: const Text('Pick Image'),
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
                                )
                              ),
                              const SizedBox(width: 16),
                              const Text('File not found.', style: TextStyle(color: Colors.red))
                            ]
                          )
                          : Row(
                            children: <Widget>[
                              ElevatedButton.icon(
                                onPressed: () => chooseFile(),
                                icon: const Icon(Icons.image),
                                label: const Text('Repick'),
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
                                )
                              ),
                              const SizedBox(width: 16),
                              Semantics(child: Image.file(File(imgFile!.path), width: 100))
                            ]
                          ),
                          const SizedBox(height: 80),
                          Center(
                            child: SizedBox(
                              height: 50,
                              width: 250,
                              child: ElevatedButton.icon(
                                onPressed: isEmpty()
                                ? () async {
                                  setState(() => load = true);
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  final ConnectivityResult net = await (Connectivity().checkConnectivity());
                                  final bool sub = await InternetConnectionChecker().hasConnection;
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
                                  else if (ctrlDesc.text.isEmpty) {
                                    setState(() => load = false);
                                    ft.showToast(
                                      child: Activity.showToast(
                                        'Description can\'t be empty',
                                        const Color(0xFFFF0000)
                                      ),
                                      toastDuration: const Duration(seconds: 1),
                                      fadeDuration: 200
                                    );
                                  }
                                  else if (ctrlPrice.text.isEmpty) {
                                    setState(() => load = false);
                                    ft.showToast(
                                      child: Activity.showToast(
                                        'Price can\'t be empty',
                                        const Color(0xFFFF0000)
                                      ),
                                      toastDuration: const Duration(seconds: 1),
                                      fadeDuration: 200
                                    );
                                  }
                                  else if (imgFile == null) {
                                    setState(() => load = false);
                                    ft.showToast(
                                      child: Activity.showToast(
                                        'Pick an image',
                                        const Color(0xFFFF0000)
                                      ),
                                      toastDuration: const Duration(seconds: 1),
                                      fadeDuration: 200
                                    );
                                  }
                                  else if (sub) {
                                    if (_formKey.currentState!.validate()) {
                                      final Templates templates = Templates(
                                        '',
                                        '',
                                        ctrlName.text,
                                        ctrlDesc.text,
                                        int.parse(ctrlPrice.text)
                                      );
                                      await TemplatesAuth.addTemplate(templates, imgFile!).then((value) {
                                        if (value == true) {
                                          setState(() => load = false);
                                          ft.showToast(
                                            child: Activity.showToast(
                                              'Published',
                                              Colors.blue
                                            ),
                                            toastDuration: const Duration(seconds: 1),
                                            fadeDuration: 200
                                          );
                                          clearForm();
                                        }
                                      });
                                    }
                                    Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
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
                                icon: const Icon(Icons.upload),
                                label: Row(
                                  children: const [
                                    Spacer(),
                                    Text(
                                      'Publish Template',
                                      style: TextStyle(fontSize: 20)
                                    ),
                                    Spacer()
                                  ]
                                )
                              )
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
    );
  }
}