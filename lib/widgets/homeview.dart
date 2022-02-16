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
    // return Card(
    //   color: brightness == Brightness.dark ? Colors.black : Colors.white,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    //   child: Container(
    //     padding: const EdgeInsets.all(8),
    //     child: ListTile(
    //       title: Text(
    //         templates.name,
    //         style: TextStyle(
    //           fontSize: 14,
    //           fontWeight: FontWeight.bold,
    //           color: brightness == Brightness.dark ? Colors.white : Colors.black,
    //         ),
    //         maxLines: 1,
    //         softWrap: true
    //       ),
    //       subtitle: Text(Activity.toIDR(templates.price),
    //         style: TextStyle(
    //           fontSize: 12,
    //           fontWeight: FontWeight.normal,
    //           color: brightness == Brightness.dark ? Colors.white : Colors.black
    //         ),
    //         maxLines: 1,
    //         softWrap: true
    //       ),
    //     )
    //   )
    // );
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Material(
        child: InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
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