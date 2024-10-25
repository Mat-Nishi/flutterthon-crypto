import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';
import 'package:fl_chart/fl_chart.dart';

class ApiService {
  static const String baseUrl = 'https://api.coingecko.com/api/v3';

  // Fetch details of a specific cryptocurrency
static Future<Crypto> fetchCryptoDetails(String cryptoId) async {
  final response = await http.get(Uri.parse('$baseUrl/coins/markets?vs_currency=usd&ids=$cryptoId'));

  // print('Fetched response: ${response.statusCode}');
  // print('Fetched data: ${response.body}');

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    if (data.isNotEmpty) {
      // print('Parsed data: ${data[0]}');
      return Crypto.fromJson(data[0]);
    }
  }

  throw Exception('Failed to load cryptocurrency data');
}

  // Fetch a list of popular cryptocurrencies (Bitcoin, Ethereum, Dogecoin)
  static Future<List<Crypto>> fetchPopularCryptos() async {
    final response = await http.get(Uri.parse('$baseUrl/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,dogecoin'));
    // print('Fetched popular cryptocurrencies response: ${response.statusCode} - ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data.map<Crypto>((item) {
        final crypto = Crypto.fromJson(item);
        // print('Fetched ${crypto.name} with price: ${crypto.currentPrice}');
        return crypto;
      }).toList();
    } else {
      throw Exception('Failed to load popular cryptocurrencies');
    }
  }
  // Fetch prices for a time period to make the chart
  static Future<List<FlSpot>> fetchHistoricalData(String cryptoId, int days) async {
    final response = await http.get(
      Uri.parse('$baseUrl/coins/$cryptoId/market_chart?vs_currency=usd&days=$days')
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<dynamic> prices = data['prices'];

      return prices.map<FlSpot>((price) {
        return FlSpot(
          (price[0] / 1000).toDouble(),
          price[1].toDouble(),
        );
      }).toList();
    } else {
      throw Exception('Failed to load historical data');
    }
  }
}
