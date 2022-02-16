part of 'services.dart';

class TemplatesAuth {
  static final CollectionReference tCollection = FirebaseFirestore.instance.collection('Templates');
  static String convertToTitleCase(String text) {
    final List<String> words = text.split(' ');
    final Iterable<String> cap = words.map((word) {
      final String first = word.trim().substring(0, 1).toUpperCase();
      final String remain = word.trim().substring(1).toLowerCase();
      return '$first$remain';
    });
    return cap.join(' ');
  }
  static DocumentReference? tDocument;
  static Reference? ref;
  static UploadTask? uploadTask;
  static String? imgUrl;
  static Future<bool> addTemplate(Templates templates, XFile imgFile) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    tDocument = await tCollection.add({
      'TID': '-',
      'Photo': templates.photo,
      'Name': convertToTitleCase(templates.name),
      'Description': templates.desc,
      'Price': templates.price,
      'Created': dateNow,
      'Updated': '-'
    });
    ref = FirebaseStorage.instance.ref().child('Template Photos').child(tDocument!.id + '.jpg');
    uploadTask = ref!.putFile(File(imgFile.path));
    await uploadTask!.whenComplete(() => ref!.getDownloadURL().then((value) => imgUrl = value));
    await tCollection.doc(tDocument!.id).update({
      'TID': tDocument!.id,
      'Photo': imgUrl
    });
    return true;
  }
  static Future<bool> updateTemplate(Templates templates, XFile imgFile) async {
    await Firebase.initializeApp();
    final String dateNow = Activity.dateNow();
    await FirebaseStorage.instance.ref().child('Template Photos').child(tDocument!.id + '.jpg').delete();
    ref = FirebaseStorage.instance.ref().child('Template Photos').child(tDocument!.id + '.jpg');
    uploadTask = ref!.putFile(File(imgFile.path));
    await uploadTask!.whenComplete(() => ref!.getDownloadURL().then((value) => imgUrl = value));
    await tCollection.doc(tDocument!.id).update({
      'Photo': imgUrl,
      'Name': convertToTitleCase(templates.name),
      'Description': templates.desc,
      'Price': templates.price,
      'Updated': dateNow
    });
    return true;
  }
  static Future<bool> deleteTemplate() async {
    await Firebase.initializeApp();
    await tCollection.doc(tDocument!.id).delete();
    await FirebaseStorage.instance.ref().child('Template Photos').child(tDocument!.id + '.jpg').delete();
    return true;
  }
}