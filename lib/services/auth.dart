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
  }
}