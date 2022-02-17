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
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: Search()
                    );
                  },
                  icon: const Icon(Icons.search)
                )
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
class Search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
   IconButton(
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        }
        else {
          query = '';
        }
      },
      icon: const Icon(Icons.cancel)
    );
   return null;
  }
  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
    );
   return null;
  }
  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}