import 'package:flutter/material.dart';
import '../models/crypto_model.dart';
import '../screens/crypto_details_page.dart';

class CryptoCard extends StatelessWidget {
  final Crypto crypto;

    CryptoCard({super.key, required this.crypto}) {
    // debugPrint('${crypto.name} card created with price: ${crypto.currentPrice}');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Text(crypto.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(
          crypto.symbol.toUpperCase(),
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('\$${crypto.currentPrice.toStringAsFixed(2)}'),
            const SizedBox(height: 5),
            Text(
              '${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
              style: TextStyle(
                color: crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CryptoDetailsPage(crypto: crypto),
            ),
          );
        },
      ),
    );
  }
}
