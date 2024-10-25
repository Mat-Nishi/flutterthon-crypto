import 'package:flutter/material.dart';
import '../models/crypto_model.dart';
import '../services/api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Crypto> _cryptos = [];
  bool _isLoading = false;

  void _searchCryptos(String query) async {
    if (query.isEmpty) {
      setState(() {
        _cryptos = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final List<Crypto> results = await ApiService.searchCryptos(query);
      setState(() {
        _cryptos = results;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addToHomepage(Crypto crypto) {
    // TODO: add coin to homepage
    print('Adding ${crypto.name} to homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Cryptocurrency'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onChanged: _searchCryptos,
              decoration: InputDecoration(
                labelText: 'Search for a cryptocurrency',
                border: const OutlineInputBorder(),
                suffixIcon: _isLoading
                    ? const CircularProgressIndicator()
                    : null,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cryptos.length,
              itemBuilder: (context, index) {
                final crypto = _cryptos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(crypto.name),
                    subtitle: Text('Price: \$${crypto.currentPrice.toStringAsFixed(2)}'),
                    trailing: ElevatedButton(
                      onPressed: () => _addToHomepage(crypto),
                      child: const Text('Add'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
