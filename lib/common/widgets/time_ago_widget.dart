import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeAgoWidget extends StatefulWidget {
  final String? dateString;

  const TimeAgoWidget({super.key, required this.dateString});

  @override
  _TimeAgoWidgetState createState() => _TimeAgoWidgetState();
}

class _TimeAgoWidgetState extends State<TimeAgoWidget> {
  String _formatTimeAgo() {
    if (widget.dateString == null || widget.dateString!.isEmpty) {
      return "No date available";
    }

    try {
      DateTime dateTime = DateTime.parse(widget.dateString!).toLocal();
      return timeago.format(dateTime, locale: 'en');
    } catch (e) {
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(_formatTimeAgo(), style: const TextStyle(fontSize: 16));
  }
}
