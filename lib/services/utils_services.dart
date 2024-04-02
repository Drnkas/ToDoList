import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UtilsServices {

  String getFormattedDate() {
    initializeDateFormatting();

    final now = DateTime.now();
    final formatter = DateFormat('EEEE d, MMMM', 'pt_BR');
    final formattedDate = formatter.format(now);

    String capitalize(String word) => word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
    return formattedDate.split(', ').map((part) => capitalize(part)).join(', ');
  }

  String formatDateAndHour(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal().subtract(Duration(hours: 3));
    String formattedDate = DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);
    return formattedDate;
  }

}
