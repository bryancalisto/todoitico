import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';

class DateHelpers {
  static String inSpanishDate(DateTime date){
    DateSymbols symbols = Map<String,DateSymbols>.from(dateTimeSymbolMap())['es']!;
    return '${date.day} de ${symbols.MONTHS[date.month - 1]} del ${date.year}';
  }
}