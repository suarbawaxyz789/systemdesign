import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class SystemDesignUtil {
  static String formatMoney({
    double? value,
    bool? displaySymbol = true,
    int? fractionDigits,
    String? symbol,
  }) {
    if (value == null) {
      return "Null";
    }
    double priceInDouble;
    if (value is int) {
      priceInDouble = double.parse(value.toString());
    } else if (value is double) {
      priceInDouble = value;
    } else {
      throw Exception("Cannot format Currency, invalid number format");
    }
    //if fraction is 0, please use int as price value.
    // if fraction greater than 0, please use use double.
    // to prevent decimal issue on multi_formatter plugin.
    if (fractionDigits == null) {
      return priceInDouble.round().toCurrencyString(
            leadingSymbol: displaySymbol == true ? (symbol ?? "Rp") : '',
            useSymbolPadding: false,
            mantissaLength: 0, //leave it zero.
          );
    } else {
      return priceInDouble.toCurrencyString(
        leadingSymbol: displaySymbol == true ? (symbol ?? "Rp") : '',
        useSymbolPadding: false,
        mantissaLength: fractionDigits,
      );
    }
  }
}
