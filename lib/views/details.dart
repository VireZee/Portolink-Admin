part of 'views.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.templates}) : super(key: key);
  final Templates templates;
  @override
  _DetailsState createState() => _DetailsState();
}
class _DetailsState extends State<Details> {
  final CollectionReference tCollection = TemplatesAuth.tCollection;
  @override
  Widget build(BuildContext context) {
    final Templates templates = widget.templates;
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
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          toolbarHeight: 75,
          elevation: 0
        ),
        body: ListView(
          children: [
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                templates.name,
                style: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532)
                )
              )
            ),
            SizedBox(height: 15.0),
                Hero(
                  tag: templates.photo,
                  child: FadeInImage(
                        height: 100,
                        width: 100,
                        placeholder: const AssetImage('assets/images/no_net_bg.png'),
                        image: NetworkImage(templates.photo)
                      )
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Text(Activity.toIDR(templates.price),
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF17532))),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Text(templates.name,
                      style: TextStyle(
                          color: Color(0xFF575E67),
                          fontSize: 24.0)),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    child: Text(templates.desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFB4B8B9))
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(0xFFF17532)
                    ),
                    child: Center(
                      child: Text('Add to cart',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                    ),
                      )
                    )
                  )
                )
          ]
        ),
      ),
    );
  }
}