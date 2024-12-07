import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loginpage/screens/tabs/addUpdateItems.dart';

class ItemListScreen extends StatefulWidget {
  final String token;
  final VoidCallback onItemDeleted;

  ItemListScreen({required this.token, required this.onItemDeleted});

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  late Future<List<dynamic>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = fetchItems();
  }

  Future<List<dynamic>> fetchItems() async {
    final url = Uri.parse('http://127.0.0.1:8000/items/');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> _deleteItem(int id) async {
    final url = Uri.parse('http://127.0.0.1:8000/items/$id/delete/');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token ${widget.token}',
      },
    );

    if (response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully')),
      );
      setState(() {
        _itemsFuture = fetchItems();
      });
      widget.onItemDeleted(); // Notify parent screen of deletion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<dynamic> items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]['name']),
                subtitle: Text(items[index]['description']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemUpdateScreen(
                              itemId: items[index]['id'],
                              itemName: items[index]['name'],
                              itemDescription: items[index]['description'],
                              itemPrice: items[index]['price'].toString(),
                              token: widget.token,
                              onUpdate: () {
                                setState(() {
                                  _itemsFuture = fetchItems();
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteItem(items[index]['id']);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
