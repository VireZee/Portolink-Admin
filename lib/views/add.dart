part of 'views.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);
  static const String routeName = '/add';
  @override
  _AddState createState() => _AddState();
}
class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlDesc = TextEditingController();
  final ctrlPrice = TextEditingController();
  XFile? imageFile;
  final ft = FToast();
  bool load = false;
  bool btn = true;
  bool isEmpty() {
    setState(() {
      if (ctrlName.text != '' && ctrlDesc.text != '' && ctrlPrice.text != '') {
        btn = true;
      }
      else {
        btn = false;
      }
    });
    return btn;
  }
  final ImagePicker imagePicker = ImagePicker();
  Future chooseFile(String type) async {
    ImageSource imgSrc = ImageSource.gallery;
    final selectedImage = await imagePicker.pickImage(
      source: imgSrc,
      imageQuality: 100
    );
    setState(() {
      imageFile = selectedImage;
    });
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
    setState(() {
      imageFile = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
              toolbarHeight: 60,
              elevation: 0,
              title: const Text('Add a New Template'),
              centerTitle: true
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
                            style: TextStyle(fontSize: 15)
                          ),
                          const SizedBox(height: 8),
                          TextField(
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
                            controller: ctrlPrice,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                            ),
                            maxLines: 1,
                            textInputAction: TextInputAction.done
                          ),
                          const SizedBox(height: 80),
                          SizedBox(
                            height: 40,
                            width: 500,
                            child: ElevatedButton.icon(
                              onPressed: () {},
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
                              icon: const Icon(Icons.upload),
                              label: Row(
                                children: const [
                                  Spacer(),
                                  Text(
                                    'Publish Template',
                                    style: TextStyle(fontSize: 20)
                                  ),
                                  Spacer(flex: 2)
                                ]
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
        )
      ]
    );
  }
}