import 'package:flutter/material.dart';
import 'package:coin_watcher/constants/currencies.dart';
import 'package:coin_watcher/constants/colors.dart';
import 'package:coin_watcher/services/networking.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  void initState() {
    initialized = initializeCharts();
    super.initState();
  }

  late Networker networker;
  Currencies currencies = Currencies();

  String selectedCurrency = 'USD';
  late var prices = [];
  late var data;
  late Future<bool> initialized;

  Future<bool> initializeCharts() async {
    networker = await Networker();
    prices = await networker.getData('USD', Currencies.cryptoList);
    setState(() {});
    return true;
  }

  void assignNewValues(List coinPrices) {
    for (var i = 0; i < coinPrices.length; i++) {
      prices[i] = coinPrices[i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Watcher💲'),
        centerTitle: true,
        backgroundColor: cryptoYellow,
      ),
      body: Center(
        child: FutureBuilder(
            future: initialized,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: Currencies.cryptoList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PriceBlock(Currencies.cryptoList, prices,
                                index, selectedCurrency);
                          }),
                    ),
                    Container(
                        color: bottomContainerColor,
                        width: double.infinity,
                        height: 100,
                        child: Center(
                          child: DropdownButton(
                              iconSize: 35,
                              enableFeedback: true,
                              hint: Text(selectedCurrency),
                              iconEnabledColor: Colors.black,
                              items: currencies.getList(),
                              onChanged: (value) async {
                                selectedCurrency = value;
                                data = await networker.getData(
                                    value, Currencies.cryptoList);
                                assignNewValues(data);
                                setState(() {});
                              }),
                        ))
                  ],
                );
              }

              return LoadingAnimationWidget.inkDrop(
                color: cryptoYellow,
                size: 100,
              );
            }),
      ),
    );
  }
}

class PriceBlock extends StatefulWidget {
  List cryptoList;
  List prices;
  int index;
  String selectedCurrency;

  PriceBlock(this.cryptoList, this.prices, this.index, this.selectedCurrency);

  @override
  State<PriceBlock> createState() => _PriceBlockState(
      this.cryptoList, this.prices, this.index, this.selectedCurrency);
}

class _PriceBlockState extends State<PriceBlock> {
  List cryptoList;
  List prices;
  int index;
  String selectedCurrency;
  _PriceBlockState(
      this.cryptoList, this.prices, this.index, this.selectedCurrency);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: shadedCryptoYellow,
      margin: EdgeInsets.all(10),
      width: 270,
      height: 50,
      child: Center(
        child: Text(
            "1 ${cryptoList[index]} = ${prices[index].toStringAsFixed(2)} $selectedCurrency"),
      ),
    );
  }
}
