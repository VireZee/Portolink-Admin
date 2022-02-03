part of 'services.dart';

class Auth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference aCollection = FirebaseFirestore.instance.collection('Admins');
  static String convertToTitleCase(String text) {
    final List<String> words = text.split(' ');
    final cap = words.map((word) {
      final String first = word.trim().substring(0, 1).toUpperCase();
      final String remain = word.trim().substring(1).toLowerCase();
      return '$first$remain';
    });
    return cap.join(' ');
  }
  static Future<String> signUp(Admins admins) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    String msg = '';
    final String token;
    final String aid;
    try {
      UserCredential aCredential = await auth.createUserWithEmailAndPassword(email: admins.email, password: admins.password);
      aid = aCredential.user!.uid;
      token = (await FirebaseMessaging.instance.getToken())!;
      await aCollection.doc(aid).set({
        'UID': aid,
        'Photo': '-',
        'Name': convertToTitleCase(admins.name),
        'Email': admins.email.replaceAll(' ', '').toLowerCase(),
        'Password': sha512.convert(utf8.encode(sha512.convert(utf8.encode(admins.password)).toString())).toString(),
        'Token': token,
        'Created': dateNow,
        'Updated': '-',
        'Entered': '-',
        'Left': '-'
      }).then((value) => msg = 'Signed');
      auth.currentUser!.updatePhotoURL(admins.photo);
      auth.currentUser!.updateDisplayName(convertToTitleCase(admins.name));
      return msg;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        msg = 'Existed';
      }
      else if (e.code == 'invalid-email') {
        msg = 'Invalid Email';
      }
      else if (e.code == 'weak-password') {
        msg = 'Invalid Pass';
      }
      else if (e.code == 'operation-not-allowed') {
        msg = 'Disabled';
      }
    }
    return msg;
  }
}