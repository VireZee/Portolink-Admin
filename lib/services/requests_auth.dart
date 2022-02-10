part of 'services.dart';

class RequestAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference rCollection = FirebaseFirestore.instance.collection('Orders');
  static DocumentReference? rDocument;
  static Reference? ref;
  static UploadTask? uploadTask;
  static String? imgUrl;
  static Future<bool> approved() async {
    await Firebase.initializeApp();
    await rCollection.doc(rDocument!.id).update({
      'Pending Status': {
        'Status': 'Approved, Waiting for payment'
      }
    });
    return true;
  }
  static Future<bool> rejected() async {
    await Firebase.initializeApp();
    await rCollection.doc(rDocument!.id).update({
      'Pending Status': {
        'Status': 'Rejected'
      }
    });
    return true;
  }
  static Future<bool> finished() async {
    await Firebase.initializeApp();
    await rCollection.doc(rDocument!.id).update({
      'Pending Status': {
        'Status': 'Finished'
      }
    });
    return true;
  }
  static Future<bool> deleted() async {
    await Firebase.initializeApp();
    await rCollection.doc(rDocument!.id).delete().then((value) => true);
    return true;
  }
}