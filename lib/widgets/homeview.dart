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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          const SizedBox(height: 15.0),
          Container(
            padding: const EdgeInsets.only(right: 15),
            width: size.width - 30,
            height: size.height - 50,
            child: GridView.count(
              crossAxisCount: 2,
              primary: false,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 0.8,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () {},
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }
}