import 'package:flutter/material.dart';

class Currencies {
  static const fiatList = [
    'AUD',
    'BRL',
    'CAD',
    'CNY',
    'EUR',
    'GBP',
    'HKD',
    'IDR',
    'ILS',
    'INR',
    'JPY',
    'MXN',
    'NOK',
    'NZD',
    'PLN',
    'RON',
    'RUB',
    'SEK',
    'SGD',
    'USD',
    'ZAR'
  ];

  static const cryptoList = ['BTC', 'ETH', 'LTC'];

  List<DropdownMenuItem> getList() {
    List<DropdownMenuItem> currencies = [];

    for (var currency in fiatList) {
      currencies.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    return currencies;
  }
}
