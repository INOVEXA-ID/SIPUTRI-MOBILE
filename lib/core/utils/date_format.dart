import 'package:intl/intl.dart';

const String _locale = 'id_ID';

extension DateTimeExtension on DateTime {
  // Day & Date
  String get dayNameShort =>
      DateFormat('E', _locale).format(this); // Sen, Sel, Rab
  String get dayNameFull =>
      DateFormat('EEEE', _locale).format(this); // Senin, Selasa
  String get dayNumber => DateFormat('dd', _locale).format(this);
  String get monthNameShort =>
      DateFormat('MMM', _locale).format(this); // Jan, Feb
  String get monthNameFull =>
      DateFormat('MMMM', _locale).format(this); // Januari, Februari
  String get monthNumber => DateFormat('MM', _locale).format(this);
  String get year => DateFormat('yyyy', _locale).format(this);

  // Date Formats
  String get dateYMD =>
      DateFormat('yyyy-MM-dd', _locale).format(this); // 2025-05-19
  String get dateDMY =>
      DateFormat('dd-MM-yyyy', _locale).format(this); // 19-05-2025
  String get dateReadable =>
      DateFormat('d MMM yyyy', _locale).format(this); // 19 Mei 2025
  String get dateFullReadable =>
      DateFormat('dd MMMM yyyy', _locale).format(this); // 19 Mei 2025
  String get dayDate => DateFormat(
    'EEEE, dd MMM yyyy',
    _locale,
  ).format(this); // Senin, 19 Mei 2025
  String get dayDateAlt => DateFormat(
    'EEEE, MMM dd, yyyy',
    _locale,
  ).format(this); // Senin, Mei 19, 2025
  String get monthYear =>
      DateFormat('MMMM yyyy', _locale).format(this); // Mei 2025

  // Time Formats
  String get timeHM => DateFormat('HH:mm', _locale).format(this);
  String get timeHMS => DateFormat('HH:mm:ss', _locale).format(this);
  String get timeWithPeriod =>
      DateFormat('hh:mm a', _locale).format(this); // 01:30 PM
  String get hour => DateFormat('HH', _locale).format(this);
  String get minute => DateFormat('mm', _locale).format(this);

  // Combined DateTime Formats
  String get dateTimeYMDHMS =>
      DateFormat('yyyy-MM-dd HH:mm:ss', _locale).format(this);
  String get fullDateTime =>
      DateFormat('E, d MMM yyyy HH:mm', _locale).format(this);
}
