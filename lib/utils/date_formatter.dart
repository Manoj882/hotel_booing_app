
import 'package:intl/intl.dart';

class DateFormatter{
  static String formatDateTime(DateTime date){
    return DateFormat("yyyy-MMM-dd a").format(date);
  }
}