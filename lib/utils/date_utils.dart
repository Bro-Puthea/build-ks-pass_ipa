import 'package:intl/intl.dart';

/// It is singleton class
class DateUtil {
  static final DateUtil _singleton = DateUtil._internal();

  factory DateUtil() {
    return _singleton;
  }

  DateUtil._internal();

  static String formatTime(String time) =>
      DateFormat.jm().format(DateFormat("hh:mm:ss").parse(time));

  String formatTimestamp(int timestamp) {
    var format = DateFormat('yyyy-MM-dd, hh:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }

  static String formatDate(String date, bool simple) {
    try {
      return simple
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(date))
          : DateFormat('dd-MM-yyyy, hh:mm:ss a').format(DateTime.parse(date));
    } catch (e) {
      return '';
    }
  }

  static String getFormattedTimeEvent(int time) {
    DateFormat newFormat = DateFormat("h:mm a");
    return newFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  DateTime getLastDayOfMonth(DateTime date) =>
      DateTime(date.year, date.month + 1, 0);

  String periodOfTimeSend(int timestamp, bool isfromMicrosecondsSinceEpoch) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date;
    if (isfromMicrosecondsSinceEpoch == true) {
      date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    } else {
      date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    }
    var diff = now.difference(date);
    var time = '';
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} DAY AGO';
      } else {
        time = '${diff.inDays} DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} WEEK AGO';
      } else {
        time = '${(diff.inDays / 7).floor()} WEEKS AGO';
      }
    }
    return time;
  }

  String periodOfTimeSendChannel(
      int timestamp, bool isfromMicrosecondsSinceEpoch) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date;
    if (isfromMicrosecondsSinceEpoch == true) {
      date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    } else {
      date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    }
    var diff = now.difference(date);
    var time = '';
    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} DAY AGO';
      } else {
        time = '${diff.inDays} DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} WEEK AGO';
      } else {
        time = '${(diff.inDays / 7).floor()} WEEKS AGO';
      }
    }
    return time;
  }
}
