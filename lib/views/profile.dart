part of 'views.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Auth.aCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_bg.jpg'),
                fit: BoxFit.fill
              )
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/no_net_bg.png'),
                  fit: BoxFit.fitWidth
                )
              )
            )
          );
        }
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_bg.jpg'),
                fit: BoxFit.fill  
              )
            ),
            child: Activity.loading()
          );
        }
        else if (snapshot.hasData) {
          return FutureBuilder(
            future: Auth.getUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile_bg.jpg'),
                      fit: BoxFit.fill
                    )
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/no_net_bg.png'),
                        fit: BoxFit.fitWidth
                      )
                    )
                  )
                );
              }
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/profile_bg.jpg'),
                      fit: BoxFit.fill  
                    )
                  ),
                  child: Activity.loading()
                );
              }
              return ProfileView(admins: snapshot.data! as Admins);
            }
          );
        }
        return Stack(
          children: snapshot.data!.docs.map((DocumentSnapshot doc) {
            final Admins admins = Admins(
              doc['Photo'],
              doc['Name'],
              doc['Email'],
              doc['Password']
            );
            return ProfileView(admins: admins);
          }).toList()
        );
      }
    );
  }
}