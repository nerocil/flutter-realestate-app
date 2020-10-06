
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AppHelper{
  static priceFormat({@required double price}) {
    final moneyFormatter = new NumberFormat("#,##0", "en_US");
    return moneyFormatter.format(price);
  }
}
