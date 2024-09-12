import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime{

  String getDateOnly() => DateFormat('dd/MM/yyyy').format(this);
  String getDateAPIOnly() => DateFormat('yyyy-MM-dd').format(this);

  String getTimeOnly() => DateFormat('hh:mm a').format(this);

}