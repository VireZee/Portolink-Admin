part of 'services.dart';

class Activity {
  static String dateNow() {
    final DateTime now = DateTime.now();
    final formatter = DateFormat('d MMMM y, KK:mm:ss.S a');
    final String date = formatter.format(now);
    return date;
  }
  static showToast(String msg, Color myColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: myColor
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          myColor == Colors.blue
          ? const Icon(Icons.check, color: Colors.white)
          : const Icon(Icons.clear, color: Colors.white),
          const SizedBox(width: 12),
          Text(msg, style: const TextStyle(color: Colors.white))
        ]
      )
    );
    /* It works only on Android Q & Below
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: myColor,
      textColor: Colors.white,
      fontSize: 14
    );
    DO NOT DELETE!!!!! */
  }
  static Container check() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black54,
      child: Lottie.asset('assets/images/auth.json')
    );
  }
  static Container loading() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black54,
      child: Lottie.asset('assets/images/loading.json')
    );
  }
  static Container sent() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Colors.black54,
      child: Lottie.asset('assets/images/sent.json')
    );
  }
  static String toIDR(String price) {
    final priceFormat = NumberFormat.currency(locale: 'ID');
    return priceFormat.format(double.parse(price));
  }
}