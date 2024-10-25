class Crypto {
  final String id;
  final String name;
  final String symbol;
  double currentPrice;
  final double priceChangePercentage24h;

  Crypto({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'] as String? ?? 'unknown',
      name: json['name'] as String? ?? 'unknown',
      symbol: json['symbol'] as String? ?? 'unknown',
      currentPrice: (json['current_price'] as num?)?.toDouble() ?? 0.0,
      priceChangePercentage24h: (json['price_change_percentage_24h'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'current_price': currentPrice,
      'price_change_percentage_24h': priceChangePercentage24h,
    };
  }
}
