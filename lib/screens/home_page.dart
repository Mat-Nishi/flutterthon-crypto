import 'package:flutter/material.dart';
import '../widgets/crypto_card.dart';
import '../services/api_service.dart';
import '../models/crypto_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<Crypto>> popularCryptos;

  @override
  void initState() {
    super.initState();
    popularCryptos = ApiService.fetchPopularCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Crypto>>(
        future: popularCryptos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cryptocurrencies found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final crypto = snapshot.data![index];
              return CryptoCard(crypto: crypto);
            },
          );
        },
      ),
    );
  }
}
