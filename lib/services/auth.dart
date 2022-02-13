part of 'services.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference aCollection = FirebaseFirestore.instance.collection('Admins');
  static String convertToTitleCase(String text) {
    final List<String> words = text.split(' ');
    final Iterable<String> cap = words.map((word) {
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
      final UserCredential aCredential = await auth.createUserWithEmailAndPassword(email: admins.email, password: admins.password);
      aid = aCredential.user!.uid;
      token = (await FirebaseMessaging.instance.getToken())!;
      await aCollection.doc(aid).set({
        'AID': aid,
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
      await auth.currentUser!.updatePhotoURL(admins.photo);
      await auth.currentUser!.updateDisplayName(convertToTitleCase(admins.name));
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
  static Future<String> signIn(String email, String password) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    String msg = '';
    final String token;
    final String aid;
    try {
      final UserCredential uCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      aid = uCredential.user!.uid;
      token = (await FirebaseMessaging.instance.getToken())!;
      await aCollection.doc(aid).update({
        'Is On': true,
        'Token': token,
        'Entered': dateNow
      }).then((value) => msg = 'Granted');
      return msg;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        msg = 'None';
      }
      else if (e.code == 'wrong-password') {
        msg = 'Hacker';
      }
      else if (e.code == 'invalid-email') {
        msg = 'Invalid Email';
      }
      else if (e.code == 'user-disabled') {
        msg = 'Disabled';
      }
      else if (e.code == 'not-found') {
        msg = 'Denied';
      }
    }
    return msg;
  }
  static Future<Admins> getUser() async {
    final String aid = auth.currentUser!.uid;
    return await aCollection.doc(aid).get().then((DocumentSnapshot doc) async {
      final Admins admins = Admins(
        doc['Photo'],
        doc['Name'],
        doc['Email'],
        doc['Password']
      );
      return admins;
    });
  }
  static Future<String> updateAccount(Admins admins) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    String msg = '';
    final String aid = auth.currentUser!.uid;
    try {
      await auth.currentUser!.updateDisplayName(convertToTitleCase(admins.name));
      await auth.currentUser!.updateEmail(admins.email.replaceAll(' ', '').toLowerCase());
      await aCollection.doc(aid).update({
        'Name': convertToTitleCase(admins.name),
        'Email': admins.email.replaceAll(' ', '').toLowerCase(),
        'Updated': dateNow
      }).then((value) => msg = 'Granted');
      return msg;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        msg = 'Existed';
      }
      else if (e.code == 'invalid-email') {
        msg = 'Invalid Email';
      }
      else if (e.code == 'requires-recent-login') {
        msg = 'Relog';
      }
    }
    return msg;
  }
  static Future<bool> signOut() async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    final String aid = auth.currentUser!.uid;
    await auth.signOut().whenComplete(() {
      aCollection.doc(aid).update({
        'Is On': false,
        'Token': '-',
        'Left': dateNow
      });
    });
    return true;
  }
  static Future<bool> deleteAccount() async {
    await Firebase.initializeApp();
    final String aid = auth.currentUser!.uid;
    aCollection.doc(aid).delete();
    auth.currentUser!.delete();
    return true;
  }
}