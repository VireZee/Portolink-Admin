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
  final CollectionReference uCollection = FirebaseFirestore.instance.collection('Users');
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
    return ThemeSwitchingArea()
  }
}