part of 'services.dart';

class Templates {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference rCollection = FirebaseFirestore.instance.collection('Templates');
  static DocumentReference? rDocument;
  static Reference? ref;
  static UploadTask? uploadTask;
  static String? imgUrl;
}