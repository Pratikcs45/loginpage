import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/screens/tabs/addUpdateItems.dart';
import 'package:loginpage/screens/tabs/itemList.dart';
import 'package:loginpage/screens/tabs/userDetail.dart';
import 'dart:convert';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final int userId;
  final String username;
  final String email;
  final String token;

  HomeScreen({
    required this.userId,
    required this.username,
    required this.email,
    required this.token,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onItemCreatedOrUpdated() {
    setState(() {
      _currentIndex = 1;
    });
  }

  Future<void> _logout(BuildContext context) async {
    final url = Uri.parse('http://127.0.0.1:8000/api/logout/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${widget.token}',
      },
      body: jsonEncode({'user_id': widget.userId}),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Logout Successful'),
          content: Text('You have been logged out successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Logout Failed'),
          content:
              Text('An error occurred while logging out. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _logout(context);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          UserDetailScreen(
            userId: widget.userId,
            username: widget.username,
            email: widget.email,
          ),
          ItemListScreen(
              token: widget.token, onItemDeleted: _onItemCreatedOrUpdated),
          AddItemScreen(
              token: widget.token, onItemCreated: _onItemCreatedOrUpdated),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Item',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.teal,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
