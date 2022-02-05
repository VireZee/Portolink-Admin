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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(child: _widgetOptions.elementAt(_selectedIntex)),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(  
                    size: Size(size.width, 80),
                    painter: Custom()
                  ),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.shopping_bag),
                      elevation: 0.1,
                      onPressed: () {}
                    )
                  ),
                  SizedBox(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.home,
                            color: _selectedIntex == 0 ? Colors.blue : null
                          ),
                          onPressed: () =>_onItemTapped(0)
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.chat,
                            color: _selectedIntex == 1 ? Colors.blue : null
                          ),
                          onPressed: () => _onItemTapped(1)
                        ),
                        Container(width: size.width * 0.20),
                        IconButton(
                          icon: Icon(
                            Icons.history,
                            color: _selectedIntex == 2 ? Colors.blue : null
                          ),
                          onPressed: () => _onItemTapped(2)
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.person,
                            color : _selectedIntex == 3 ? Colors.blue : null
                          ),
                          onPressed: () => _onItemTapped(3)
                        )
                      ]
                    )
                  )
                ]
              )
            )
          )
        ]
      )
    );
  }
}