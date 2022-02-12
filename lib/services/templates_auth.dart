part of 'services.dart';

class TemplatesAuth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final CollectionReference tCollection = FirebaseFirestore.instance.collection('Templates');
  static DocumentReference? tDocument;
  static Reference? ref;
  static UploadTask? uploadTask;
  static String? imgUrl;
  static Future<bool> addTemplate(Templates templates, PickedFile imgFile) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    ref = FirebaseStorage.instance.ref().child('Template Photos').child(tDocument!.id + 'jpg');
    uploadTask = ref!.putFile(File(imgFile.path));
    await uploadTask!.whenComplete(() => ref!.getDownloadURL().then((value) => imgUrl = value));
    await tCollection.doc(tDocument!.id).set({
      'TID': tDocument!.id,
      'Photo': imgUrl,
      'Name': templates.name,
      'Description': templates.desc,
      'Price': templates.price,
      'Created': dateNow,
      'Updated': '-'
    });
    return true;
  }
  static Future<bool> updateTemplate(Templates templates, PickedFile imgFile, String photo) async {
    await Firebase.initializeApp();
    String dateNow = Activity.dateNow();
    ref = FirebaseStorage.instance.ref().child('Template Photos').child(tDocument!.id + 'jpg');
    uploadTask = ref!.putFile(File(imgFile.path));
    await uploadTask!.whenComplete(() => ref!.getDownloadURL().then((value) => imgUrl = value));
    await tCollection.doc(tDocument!.id).update({
      'TID': tDocument!.id,
      'Photo': imgUrl,
      'Name': templates.name,
      'Description': templates.desc,
      'Price': templates.price,
      'Updated': dateNow
    });
    return true;
  }
}