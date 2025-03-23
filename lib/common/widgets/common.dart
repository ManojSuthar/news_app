import 'package:timeago/timeago.dart' as timeago;

class Common {
  static String formatTimeAgo(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "No date available";

    try {
      DateTime dateTime =
          DateTime.parse(dateString).toLocal(); // Convert UTC to Local
      return timeago.format(dateTime);
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid date";
    }
  }
}
