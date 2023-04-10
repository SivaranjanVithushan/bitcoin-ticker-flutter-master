import 'dart:convert';
import 'package:http/http.dart' as http;


const List<String> currenciesList = [
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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'A17D5877-26AA-47AB-99ED-5B0F4DE48C78';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    //4. Create a url combining the coinAPIURL with the currencies we're interested, BTC to USD.
    Map<String, String> cryptoPrice ={};
    for (String crypto in cryptoList){
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';

      Uri uri = Uri.parse(requestURL);
      //5. Make a GET request to the URL and wait for the response.
      http.Response response = await http.get(uri);

      //6. Check that the request was successful.
      if (response.statusCode == 200) {
        //7. Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
        var decodedData = jsonDecode(response.body);
        //8. Get the last price of bitcoin with the key 'last'.
        var lastPrice = decodedData['rate'];
        //print(lastPrice.toStringAsFixed(0));
        //9. Output the lastPrice from the method.
        cryptoPrice[crypto] = lastPrice.toStringAsFixed(2);
        // return lastPrice;
      } else {
        //10. Handle any errors that occur during the request.
        print(response.statusCode);
        //Optional: throw an error if our request fails.
        throw 'Problem with the get request';
      }
    }
    // print(cryptoPrice.values);
  return cryptoPrice;
  }
}
