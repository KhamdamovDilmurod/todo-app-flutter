import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension CustomDateTime on DateTime {
  get formattedDate {
    return DateFormat('dd.MM.yyyy').format(this);
  }

  get formattedDateTime {
    return DateFormat('dd.MM.yyyy HH:mm:ss').format(this);
  }
}

extension CustomTime on TimeOfDay {
  get formattedTime {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}

// extension CustomDouble on double {
//   String formattedAmount({bool? withSymbol, Currency? currency}) {
//     withSymbol = withSymbol ?? false;
//     var summa = _thousandDecimalFormat(this);
//     if (withSymbol) {
//       summa = summa + (" ${_typeCur(currency)}");
//     }
//     return summa;
//   }
//
//   double fixed({int? fix}) {
//     fix ??= 2;
//     return double.parse(toStringAsFixed(fix));
//   }
// }
//
// extension CustomStringAmount on String {
//   String formattedAmount({bool? withSymbol, Currency? currency}) {
//     withSymbol ??= false;
//     var summa = _thousandDecimalFormat(parseToDouble());
//     if (withSymbol) {
//       summa = summa + (" ${_typeCur(currency)}");
//     }
//     return summa;
//   }
//
//   double parseToDouble() {
//     var value = replaceAll(" ", "");
//     var item = double.parse(value.isEmpty ? "0.0" : value);
//     return item.fixed();
//   }
// }
//
// String _thousandDecimalFormat(double? value) {
//   var afterDot = 2;
//
//   var num = value.toString();
//   var numberDecimal = num.substring(num.indexOf('.') + 1);
//   final numberInteger = List.from(num.substring(0, num.indexOf('.')).split(''));
//   int index = numberInteger.length - 3;
//   while (index > 0) {
//     numberInteger.insert(index, ' ');
//     index -= 3;
//   }
//   if (numberDecimal.length > afterDot) {
//     numberDecimal = numberDecimal.substring(0, 2);
//   }
//   return "${numberInteger.join()}.$numberDecimal";
// }
//
// dynamic _typeCur(Currency? currency) {
//   var type = "";
//   currency ??= Currency.SUM;
//   switch (currency) {
//     case Currency.DOLLAR:
//       type = "\$";
//       break;
//     case Currency.SUM:
//       type = "сум";
//       break;
//   }
//   return type;
// }
