part of 'widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.templates}) : super(key: key);
  final Templates templates;
  @override
  _HomeViewState createState() => _HomeViewState();
}
Future<bool> sub() async {
  final bool sub = await InternetConnectionChecker().hasConnection;
  if (sub) {
    return true;
  }
  else {
    return false;
  }
}
class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final Templates templates = widget.templates;
    final Brightness brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(
                templates: templates,
              )
            )
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Hero(
                  tag: templates.photo,
                  child: FadeInImage(
                    height: 100,
                    width: 100,
                    placeholder: const AssetImage('assets/images/no_net_bg.png'),
                    image: NetworkImage(templates.photo)
                  )
                ),
                const SizedBox(height: 30),
                Text(
                  Activity.toIDR(templates.price),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: brightness == Brightness.dark ? Colors.white : Colors.black
                  )
                ),
                Text(
                  templates.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: brightness == Brightness.dark ? Colors.white : Colors.black
                  )
                )
              ]
            )
          ),
          highlightColor: Colors.blue,
          borderRadius: BorderRadius.circular(10)
        ),
        color: brightness == Brightness.dark ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))
      )
    );
  }
}