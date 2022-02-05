part of 'views.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  static const String routeName = '/main';
  @override
  _MainMenuState createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu> {
  static int _selectedIntex = 3;
  final List<Widget> _widgetOptions = <Widget>[
    // const Home(),
    // const Chat(),
    // const History(),
    // const Profile()
  ];
  void _onItemTapped(int index) {
    setState(() => _selectedIntex = index);
  } 
  @override
  Widget build(BuildContext context) {
  }
}