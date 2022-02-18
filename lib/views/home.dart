part of 'views.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  String trigger = '';
  Stream<QuerySnapshot> sort() {
    Stream<QuerySnapshot> s = TemplatesAuth.tCollection.orderBy('Name').snapshots();
    setState(() {
      if (trigger == 'nd') {
        s = TemplatesAuth.tCollection.orderBy('Name').snapshots();
      }
      else if (trigger == 'nu') {
        s = TemplatesAuth.tCollection.orderBy('Name', descending: true).snapshots();
      }
      else if (trigger == 'pd') {
        s = TemplatesAuth.tCollection.orderBy('Price').snapshots();
      }
      else if (trigger == 'pu') {
        s = TemplatesAuth.tCollection.orderBy('Price', descending: true).snapshots();
      }
    });
    return s;
  }
  @override
  Widget build(BuildContext context) {
    final Brightness brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
    final Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: sort(),
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
            backgroundColor: Colors.transparent,
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
              title: SizedBox(
                width: size.width - size.width * 0.15,
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15
                  ),
                  decoration: InputDecoration(
                    hintText: 'W bingung ini gimana 😭😭😭',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  maxLines: 1,
                  textInputAction: TextInputAction.done
                )
              ),
              actions: [
                PopupMenuButton(
                  color: brightness == Brightness.dark ? Colors.black : Colors.white,
                  icon: const Icon(Icons.sort),
                  tooltip: 'Sort',
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () => setState(() => trigger = 'nd'),
                      child: Row(
                        children: [
                          Text('Name', style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black)),
                          const Spacer(flex: 2),
                          Icon(Icons.arrow_downward, color: brightness == Brightness.dark ? Colors.white : Colors.black),
                          const Spacer()
                        ]
                      )
                    ),
                    PopupMenuItem(
                      onTap: () => setState(() => trigger = 'nu'),
                      child: Row(
                        children: [
                          Text('Name', style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black)),
                          const Spacer(flex: 2),
                          Icon(Icons.arrow_upward, color: brightness == Brightness.dark ? Colors.white : Colors.black),
                          const Spacer() 
                        ]
                      )
                    ),
                    PopupMenuItem(
                      onTap: () => setState(() => trigger = 'pd'),
                      child: Row(
                        children: [
                          Text('Price', style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black)),
                          const Spacer(flex: 2),
                          Icon(Icons.arrow_downward, color: brightness == Brightness.dark ? Colors.white : Colors.black),
                          const Spacer()
                        ]
                      )
                    ),
                    PopupMenuItem(
                      onTap: () => setState(() => trigger = 'pu'),
                      child: Row(
                        children: [
                          Text('Price', style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black)),
                          const Spacer(flex: 2),
                          Icon(Icons.arrow_upward, color: brightness == Brightness.dark ? Colors.white : Colors.black),
                          const Spacer()
                        ]
                      )
                    )
                  ],
                )
              ]
            ),
            body: SizedBox(
              height: size.height - size.height * 0.2,
              child: GridView.count(
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
              ),
            )
          )
        );
      }
    );
  }
}