// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const BitcoinPrice());
}

class BitcoinPrice extends StatefulWidget {
  const BitcoinPrice({Key? key}) : super(key: key);

  @override
  _BicoinPriceState createState() => _BicoinPriceState();
}

class _BicoinPriceState extends State<BitcoinPrice> {
  var iranImgUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmiyr-32DsbKWzGE0FzPyJXs59VRiilHFU-KyM3l-8tXunrBCr4xtUt7ju8jZZyVsEFgM&usqp=CAU';

  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  Future<dynamic> getApiBitcoin() async {
    var url = 'https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=IRR';
    var dio = Dio();
    var response = await dio.get(url);
    final jsonReponse = json.decode(response.toString());
    return jsonReponse;
  }

  var btc;

  Future<dynamic> getApiEtt() async {
    var url = 'https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=IRR';
    var dio = Dio();
    var response = await dio.get(url);
    final jsonReponse = json.decode(response.toString());
    return jsonReponse;
  }

  var ett;

  @override
  void initState() {
    getApiBitcoin().then((value) {
      setState(() {
        btc = value["IRR"];
      });
    });
    getApiEtt().then((value) {
      setState(() {
        ett = value["IRR"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Price Bitcoin',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Image.network(iranImgUrl, width: 40),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  myFormat.format(btc),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Price Ethereum IR',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Image.network(iranImgUrl, width: 40),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  myFormat.format(ett),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
