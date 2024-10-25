import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/search_page.dart';
import 'screens/info_page.dart';

void main() {
  runApp(const CryptoApp());
}

class CryptoApp extends StatelessWidget {
  const CryptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CryptoHome(),
    );
  }
}

class CryptoHome extends StatefulWidget {
  const CryptoHome({super.key});

  @override
  CryptoHomeState createState() => CryptoHomeState(); 
}

class CryptoHomeState extends State<CryptoHome> {  
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const SearchPage(),
    const InfoPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crypto Checker')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
