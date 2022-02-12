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
  PickedFile? imageFile;
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
    final selectedImage = await imagePicker.getImage(
      source: imgSrc,
      imageQuality: 100
    );
    setState(() {
      imageFile = selectedImage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}