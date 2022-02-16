part of 'widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.templates}) : super(key: key);
  final Templates templates;
  @override
  _HomeViewState createState() => _HomeViewState();
}
class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final Templates templates = widget.templates;
    final Brightness brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: brightness == Brightness.dark ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 2 
                )
              ]
            ),
            child: Column(
              children: [
                Text(
                  Activity.toIDR(templates.price),
                  style: TextStyle(
                    fontSize: 14,
                    color: brightness == Brightness.dark ? Colors.white : Colors.black
                  )
                ),
                Text(
                  templates.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: brightness == Brightness.dark ? Colors.white : Colors.black
                  )
                )
              ]
            )
          ),
          highlightColor: Colors.blue,
          borderRadius: BorderRadius.circular(10)
        ),
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10))
      )
    );
  }
}