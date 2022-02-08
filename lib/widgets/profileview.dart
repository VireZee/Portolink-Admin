part of 'widgets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.admins}) : super(key: key);
  final Admins admins;
  @override
  _ProfileViewState createState() => _ProfileViewState();
}
class _ProfileViewState extends State<ProfileView> {
  final ft = FToast();
  static bool load = false;
  static bool c = true;
  @override
  void initState() {
    super.initState();
    ft.init(context);
  }
  @override
  Widget build(BuildContext context) {
    final Admins admins = widget.admins;
    return Container();
  }
}