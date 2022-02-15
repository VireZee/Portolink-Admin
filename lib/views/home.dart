part of 'views.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    return StreamBuilder<QuerySnapshot>(
      stream: TemplatesAuth.tCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('No Data', style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black))
            )
          );
        }
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Activity.loading()
            )
          );
        }
        else if (snapshot.hasData) {
          return FutureBuilder(
            future: TemplatesAuth.getTemplate(),
            builder: (context, snapshot) {
              // if (snapshot.hasError) {
              //   return Scaffold(
              //     body: Center(
              //       child: Text('No Data', style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black))
              //     )
              //   );
              // }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: Activity.loading()
                  )
                );
              }
              return HomeView(templates: snapshot.data as Templates);
            }
          );
        }
        return Stack(
          children: snapshot.data!.docs.map((DocumentSnapshot doc) {
            final Templates templates = Templates(
              doc['Name'],
              doc['Description'],
              doc['Price']
            );
            return HomeView(templates: templates);
          }).toList()
        );
      }
    );
  }
}