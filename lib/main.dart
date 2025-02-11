import 'package:flutter/material.dart';//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home.dart';
import 'login.dart';


void main() {
  runApp( ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('WhatsApp', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF128C7E),
        actions: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          // Barre d'onglets
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                tabItem("Chats", true),
                tabItem("Updates", false),
                tabItem("Communities", false),
                tabItem("Calls", false),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey),

          // Liste de conversations fictives
          Expanded(
            child: ListView(
              children: [
                chatItem("HOUNYE O ctavio", "You: WhatsApp Beta...", "08:45 AM"),
                chatItem("FBI BENIN", "You: WhatsApp Beta...", "07:15 AM"),
                chatItem("PAPA", "Je serai la ce soir...", "Yesterday"),
                chatItem("Bae", "Viens me voir ce soir", "12/23"),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Color(0xFF128C7E),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.update), label: 'Updates'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Communities'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFF25D366),
        child: Icon(Icons.message, color: Colors.white),
      ),
    );
  }

  Widget tabItem(String label, bool isSelected) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? Color(0xFF128C7E) : Colors.black,
      ),
    );
  }

  Widget chatItem(String title, String subtitle, String time) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[300],
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Text(time, style: TextStyle(color: Colors.grey)),
    );
  }
}