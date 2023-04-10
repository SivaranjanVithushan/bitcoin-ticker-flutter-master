import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  String bitcoinValue = '?';

  Map<String, String> coinValues ={};
  bool isWaiting = false;

  void getData() async{
    isWaiting = true;
    try{
      print(selectedCurrency);
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState((){
        coinValues = data;
      });

    }catch(e){
      print(e);
    }
  }

  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget>[
              CryptoCard(
                cryptoCurrency: 'BTC',
                value: isWaiting ? '?': coinValues['BTC'] ,
                selectedCurrency: selectedCurrency ,
              ),
              CryptoCard(
                cryptoCurrency: 'ETH',
                value: isWaiting ? '?': coinValues['ETH'] ,
                selectedCurrency: selectedCurrency ,
              ),
              CryptoCard(
                cryptoCurrency: 'LTC',
                value: isWaiting ? '?': coinValues['LTC'] ,
                selectedCurrency: selectedCurrency ,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String value) {
                // This is called when the user selects an item.
                setState(() {
                  selectedCurrency = value;
                  getData();
                });
              },
              items:
                  currenciesList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  // const CryptoCard({Key? key}) : super(key: key);
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
});
  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
