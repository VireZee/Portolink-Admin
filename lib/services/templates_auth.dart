part of 'services.dart';

class TemplatesAuth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference rCollection = FirebaseFirestore.instance.collection('Templates');
  static DocumentReference? rDocument;
  static Reference? ref;
  static UploadTask? uploadTask;
  static String? imgUrl;
  static Future<bool> addTemplate(Templates templates, PickedFile imgFile) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
  }
}