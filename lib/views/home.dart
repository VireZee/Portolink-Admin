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
        if (Auth.auth.currentUser == null) {
          return Scaffold(
            body: Center(
              child: Text('No Data', style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black))
            )
          );
        }
        else if (snapshot.hasError) {
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
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home_bg.jpg'),
              fit: BoxFit.fill
            )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: 75,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                TextField(
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 25
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  maxLines: 1,
                  textInputAction: TextInputAction.done
                ),
              ]
            ),
            body: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 3,
              primary: false,
              childAspectRatio: 0.6,
              children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                final Templates templates = Templates(
                  doc['TID'],
                  doc['Photo'],
                  doc['Name'],
                  doc['Description'],
                  doc['Price']
                );
                return HomeView(templates: templates);
              }).toList()
            )
          )
        );
      }
    );
  }
}