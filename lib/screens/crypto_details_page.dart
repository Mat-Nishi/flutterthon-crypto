import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/crypto_model.dart';
import '../services/api_service.dart';

class CryptoDetailsPage extends StatefulWidget {
  final Crypto crypto;

  const CryptoDetailsPage({super.key, required this.crypto});

  @override
  CryptoDetailsPageState createState() => CryptoDetailsPageState();
}

class CryptoDetailsPageState extends State<CryptoDetailsPage> {
  List<FlSpot>? chartData;
  double? averagePrice;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCryptoDetails();
  }

  void fetchCryptoDetails() async {
    try {
      Crypto detailedCrypto = await ApiService.fetchCryptoDetails(widget.crypto.id);
      
      // print('API Response: ${detailedCrypto.toJson()}'); 

      // Fetch historical data for chart
      List<FlSpot> historicalData = await ApiService.fetchHistoricalData(widget.crypto.id, 7);
      averagePrice = historicalData.map((spot) => spot.y).reduce((a, b) => a + b) / historicalData.length;

      setState(() {
        chartData = historicalData;
        widget.crypto.currentPrice = detailedCrypto.currentPrice;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching details: $e');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.crypto.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else ...[
              Text(
                'Current Price: \$${widget.crypto.currentPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              const Text(
                'Price Variation:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: chartData != null
                    ? LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: chartData!,
                              isCurved: true,
                              colors: chartData!.map((spot) => spot.y < averagePrice! ? Colors.red : Colors.green).toList(),
                              barWidth: 4,
                              belowBarData: BarAreaData(
                                show: true,
                                colors: chartData!.map((spot) => spot.y < averagePrice! ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3)).toList(),
                              ),
                            ),
                          ],
                          titlesData: FlTitlesData(show: false),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                        ),
                      )
                    : const Center(child: Text('No data available')),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
