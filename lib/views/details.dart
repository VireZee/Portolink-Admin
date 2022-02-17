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
    final Brightness brightness = ThemeModelInheritedNotifier.of(context).theme.brightness;
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
        extendBodyBehindAppBar: true,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              templates.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Oswald',
                fontSize: 50,
                color: Colors.blue
              )
            ),
            const SizedBox(height: 15),
            Hero(
              tag: templates.photo,
              child: FadeInImage(
                placeholder: const AssetImage('assets/images/no_net_bg.png'),
                image: NetworkImage(templates.photo)
              )
            ),
            const SizedBox(height: 20.0),
            Text(
              Activity.toIDR(templates.price),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Dancing Script',
                fontSize: 25,
                color: Colors.blue
              )
            ),
            const SizedBox(height: 20.0),
            Text(
              templates.desc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Flamenco',
                fontSize: 25,
                color: Colors.blue
              )
            ),
            const SizedBox(height: 100),
            Column(
              children: [
                SizedBox(
                  height: 60,
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edit(
                          tid: templates.tid,
                          photo: templates.photo,
                          name: templates.name,
                          desc: templates.desc,
                          price: templates.price
                        )
                      )
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        return states.contains(MaterialState.pressed)
                        ? Colors.blue
                        : null;
                      }),
                      foregroundColor: MaterialStateProperty.resolveWith((states) {
                        return states.contains(MaterialState.pressed)
                        ? const Color(0xFF00FF00)
                        : null;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                      )
                    ),
                    icon: const Icon(Icons.edit),
                    label: Row(
                      children: const [
                        Spacer(),
                        Text('Edit Template', style: TextStyle(fontFamily: 'Prompt', fontSize: 25)),
                        Spacer(flex: 1)
                      ]
                    )
                  )
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: brightness == Brightness.dark ? Colors.black : Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          title: Text(
                            'Confirmation',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black)
                          ),
                          content: Text(
                            'Are you sure you want to delete this item?',
                            style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black)
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black)
                              ),
                              onPressed: () => Navigator.of(context).pop()
                            ),
                            TextButton(
                              child: Text(
                                'Delete',
                                style: TextStyle(color: brightness == Brightness.dark ? Colors.white : Colors.black)
                              ),
                              onPressed: () {
                                TemplatesAuth.deleteTemplate(templates.tid);
                                Navigator.pushNamedAndRemoveUntil(context, '/main', (Route<dynamic> route) => false);
                              }
                            )
                          ]
                        )
                      );
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith((states) {
                        return states.contains(MaterialState.pressed)
                        ? Colors.blue
                        : null;
                      }),
                      foregroundColor: MaterialStateProperty.resolveWith((states) {
                        return states.contains(MaterialState.pressed)
                        ? const Color(0xFFFF0000)
                        : null;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
                      )
                    ),
                    icon: const Icon(Icons.clear),
                    label: Row(
                      children: const [
                        Spacer(),
                        Text('Delete Template',style: TextStyle(fontFamily: 'Prompt', fontSize: 25)),
                        Spacer(flex: 1)
                      ]
                    )
                  )
                )
              ]
            )
          ]
        )
      )
    );
  }
}