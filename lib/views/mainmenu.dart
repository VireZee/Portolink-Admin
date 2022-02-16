part of 'views.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  static const String routeName = '/main';
  @override
  _MainMenuState createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu> {
  static int _selectedIntex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const Chat(),
    const Transaction(),
    const Profile()
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
                      child: const Icon(Icons.add),
                      elevation: 0.1,
                      onPressed: () {
                        Navigator.pushNamed(context, '/add');
                      }
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
                            Icons.list_alt,
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
class Custom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..shader = const SweepGradient(
      colors: [
        Color(0xFF4ADEDE),
        Color(0xFF1CA7EC)
      ]
    ).createShader(Rect.largest)..style = PaintingStyle.fill;
    final Path path = Path();
    path.moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(
      Offset(size.width * 0.60, 20),
      radius: const Radius.circular(20.0),
      clockwise: false
    );
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}